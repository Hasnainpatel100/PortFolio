import 'package:equatable/equatable.dart';
import '../../core/constants/portfolio_data.dart';

/// Portfolio States
abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

/// Loading state
class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

/// Loaded state with all portfolio data
class PortfolioLoaded extends PortfolioState {
  final List<ProjectData> projects;
  final List<ProjectData> filteredProjects;
  final String? selectedCategory;
  final bool isDarkMode;
  final String? currentSection;

  const PortfolioLoaded({
    required this.projects,
    required this.filteredProjects,
    this.selectedCategory,
    this.isDarkMode = true,
    this.currentSection,
  });

  @override
  List<Object?> get props => [
        projects,
        filteredProjects,
        selectedCategory,
        isDarkMode,
        currentSection,
      ];

  PortfolioLoaded copyWith({
    List<ProjectData>? projects,
    List<ProjectData>? filteredProjects,
    String? selectedCategory,
    bool? isDarkMode,
    String? currentSection,
  }) {
    return PortfolioLoaded(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentSection: currentSection ?? this.currentSection,
    );
  }
}

/// Contact form submission states
class ContactFormSubmitting extends PortfolioState {
  const ContactFormSubmitting();
}

class ContactFormSuccess extends PortfolioState {
  final String message;

  const ContactFormSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactFormError extends PortfolioState {
  final String error;

  const ContactFormError(this.error);

  @override
  List<Object?> get props => [error];
}

/// Error state
class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}
