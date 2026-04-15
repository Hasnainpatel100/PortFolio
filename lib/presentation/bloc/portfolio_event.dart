import 'package:equatable/equatable.dart';

/// Portfolio Events
abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

/// Load portfolio data
class LoadPortfolioData extends PortfolioEvent {
  const LoadPortfolioData();
}

/// Navigate to section
class NavigateToSection extends PortfolioEvent {
  final String sectionId;

  const NavigateToSection(this.sectionId);

  @override
  List<Object?> get props => [sectionId];
}

/// Submit contact form
class SubmitContactForm extends PortfolioEvent {
  final String name;
  final String email;
  final String message;

  const SubmitContactForm({
    required this.name,
    required this.email,
    required this.message,
  });

  @override
  List<Object?> get props => [name, email, message];
}

/// Download resume
class DownloadResume extends PortfolioEvent {
  const DownloadResume();
}

/// Toggle theme
class ToggleTheme extends PortfolioEvent {
  const ToggleTheme();
}

/// Filter projects by category
class FilterProjects extends PortfolioEvent {
  final String? category;

  const FilterProjects(this.category);

  @override
  List<Object?> get props => [category];
}
