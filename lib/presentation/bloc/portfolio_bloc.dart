import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/services/email_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

/// Portfolio BLoC - Handles all portfolio state management
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final FirebaseFirestore? _firestore;

  PortfolioBloc({FirebaseFirestore? firestore})
      : _firestore = firestore,
        super(const PortfolioInitial()) {
    on<LoadPortfolioData>(_onLoadPortfolioData);
    on<NavigateToSection>(_onNavigateToSection);
    on<SubmitContactForm>(_onSubmitContactForm);
    on<DownloadResume>(_onDownloadResume);
    on<ToggleTheme>(_onToggleTheme);
    on<FilterProjects>(_onFilterProjects);
  }

  /// Load portfolio data
  Future<void> _onLoadPortfolioData(
    LoadPortfolioData event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioLoading());

    try {
      // Simulate loading delay for animations
      await Future.delayed(const Duration(milliseconds: 500));

      // Load projects from constants
      final projects = PortfolioData.projects;

      emit(PortfolioLoaded(
        projects: projects,
        filteredProjects: projects,
        selectedCategory: null,
        isDarkMode: true,
      ));
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio: ${e.toString()}'));
    }
  }

  /// Navigate to a specific section
  Future<void> _onNavigateToSection(
    NavigateToSection event,
    Emitter<PortfolioState> emit,
  ) async {
    if (state is PortfolioLoaded) {
      final currentState = state as PortfolioLoaded;
      emit(currentState.copyWith(currentSection: event.sectionId));
    }
  }

  /// Submit contact form using EmailJS
  Future<void> _onSubmitContactForm(
    SubmitContactForm event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const ContactFormSubmitting());

    try {
      // Validate inputs
      if (event.name.isEmpty || event.email.isEmpty || event.message.isEmpty) {
        emit(const ContactFormError('Please fill all fields'));
        return;
      }

      // Email validation
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(event.email)) {
        emit(const ContactFormError('Please enter a valid email'));
        return;
      }

      // Bypass EmailJS and use url_launcher directly
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: PortfolioData.email,
        queryParameters: {
          'subject': 'Portfolio Contact from ${event.name}',
          'body': 'From: ${event.name} (${event.email})\n\nMessage:\n${event.message}',
        },
      );

      bool emailSent = false;
      try {
        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
          emailSent = true;
        }
      } catch (e) {
        emailSent = false;
      }

      if (!emailSent) {
        emit(const ContactFormError(
          'Failed to launch email client.',
        ));
        return;
      }

      // Optional: Also save to Firestore if available
      if (_firestore != null) {
        try {
          await _firestore.collection('contact_messages').add({
            'name': event.name,
            'email': event.email,
            'message': event.message,
            'timestamp': FieldValue.serverTimestamp(),
            'status': 'new',
          });
        } catch (firestoreError) {
          // Log but don't fail if Firestore save fails (email was still sent)
          print('⚠️ Firestore save failed: $firestoreError');
        }
      }

      // Success
      emit(const ContactFormSuccess(
          'Thank you! Your message has been sent successfully. I\'ll get back to you soon!'));

      // Return to loaded state after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      if (state is ContactFormSuccess) {
        final projects = PortfolioData.projects;
        emit(PortfolioLoaded(
          projects: projects,
          filteredProjects: projects,
          selectedCategory: null,
          isDarkMode: true,
        ));
      }
    } catch (e) {
      emit(const ContactFormError(
        'An unexpected error occurred. Please try again or contact me directly.',
      ));
    }
  }

  /// Download resume
  Future<void> _onDownloadResume(
    DownloadResume event,
    Emitter<PortfolioState> emit,
  ) async {
    // This will be handled in the UI layer with url_launcher
    // You can add analytics tracking here if needed
  }

  /// Toggle theme
  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<PortfolioState> emit,
  ) async {
    if (state is PortfolioLoaded) {
      final currentState = state as PortfolioLoaded;
      emit(currentState.copyWith(isDarkMode: !currentState.isDarkMode));
    }
  }

  /// Filter projects by category
  Future<void> _onFilterProjects(
    FilterProjects event,
    Emitter<PortfolioState> emit,
  ) async {
    if (state is PortfolioLoaded) {
      final currentState = state as PortfolioLoaded;

      final filteredProjects = event.category == null || event.category == 'All'
          ? currentState.projects
          : currentState.projects
              .where((project) => project.category == event.category)
              .toList();

      emit(currentState.copyWith(
        filteredProjects: filteredProjects,
        selectedCategory: event.category,
      ));
    }
  }
}
