import 'portfolio_data.dart';

/// Knowledge base for the chatbot with pattern matching
class ChatbotKnowledgeBase {
  /// Initial suggestions shown when chat opens
  static const List<String> initialSuggestions = [
    'Who is Hasnain?',
    'What are your skills?',
    'Show me projects',
    'How to contact?',
  ];

  /// Find the best matching response for user input
  static ChatResponse getResponse(String userInput) {
    final normalized = userInput.toLowerCase().trim();

    // Check each intent pattern
    for (final intent in _intents) {
      for (final keyword in intent.keywords) {
        if (normalized.contains(keyword)) {
          return ChatResponse(
            message: intent.responseGenerator(),
            suggestions: intent.followUpSuggestions,
          );
        }
      }
    }

    // Fallback response
    return ChatResponse(
      message: _fallbackResponse(),
      suggestions: initialSuggestions,
    );
  }

  /// List of intents with keywords and response generators
  static final List<_ChatIntent> _intents = [
    // Greeting
    _ChatIntent(
      keywords: ['hi', 'hello', 'hey', 'hola', 'greetings', 'good morning', 'good evening'],
      responseGenerator: _greetingResponse,
      followUpSuggestions: ['Who is Hasnain?', 'Skills', 'Projects', 'Contact'],
    ),

    // About / Who
    _ChatIntent(
      keywords: ['who', 'about', 'introduce', 'yourself', 'tell me about', 'hasnain'],
      responseGenerator: _aboutResponse,
      followUpSuggestions: ['Skills', 'Experience', 'Projects'],
    ),

    // Skills
    _ChatIntent(
      keywords: ['skills', 'technologies', 'tech stack', 'what can', 'expertise', 'know'],
      responseGenerator: _skillsResponse,
      followUpSuggestions: ['Flutter details', 'State management', 'Projects'],
    ),

    // Flutter specific
    _ChatIntent(
      keywords: ['flutter', 'dart', 'mobile app', 'cross-platform'],
      responseGenerator: _flutterResponse,
      followUpSuggestions: ['State management', 'Projects', 'Experience'],
    ),

    // State Management
    _ChatIntent(
      keywords: ['bloc', 'provider', 'riverpod', 'getx', 'state management'],
      responseGenerator: _stateManagementResponse,
      followUpSuggestions: ['Flutter skills', 'Projects', 'Experience'],
    ),

    // Experience
    _ChatIntent(
      keywords: ['experience', 'work', 'job', 'career', 'company', 'companies', 'worked', 'rh pos', 'pos'],
      responseGenerator: _experienceResponse,
      followUpSuggestions: ['Current role', 'Projects', 'Skills'],
    ),

    // Projects
    _ChatIntent(
      keywords: ['projects', 'portfolio', 'work samples', 'built', 'apps', 'applications'],
      responseGenerator: _projectsResponse,
      followUpSuggestions: ['Restaurant App', 'Supermarket POS', 'NASA Platform'],
    ),

    // Specific projects
    _ChatIntent(
      keywords: ['restaurant', 'restaurant management'],
      responseGenerator: () => _specificProjectResponse('Restaurant Management App'),
      followUpSuggestions: ['Other projects', 'Skills', 'Contact'],
    ),
    _ChatIntent(
      keywords: ['supermarket', 'pos', 'inventory point of sale'],
      responseGenerator: () => _specificProjectResponse('Supermarket POS'),
      followUpSuggestions: ['Other projects', 'Skills', 'Contact'],
    ),
    _ChatIntent(
      keywords: ['nasa', 'fire safety', 'digital product showcase'],
      responseGenerator: () => _specificProjectResponse('NASA Fire Safety'),
      followUpSuggestions: ['Other projects', 'Skills', 'Contact'],
    ),
    _ChatIntent(
      keywords: ['cookify', 'recipe', 'food'],
      responseGenerator: () => _specificProjectResponse('Cookify'),
      followUpSuggestions: ['Other projects', 'Skills', 'Contact'],
    ),

    // Education
    _ChatIntent(
      keywords: ['education', 'study', 'degree', 'college', 'university', 'qualification', 'school'],
      responseGenerator: _educationResponse,
      followUpSuggestions: ['Experience', 'Skills', 'Projects'],
    ),

    // Contact
    _ChatIntent(
      keywords: ['contact', 'email', 'phone', 'reach', 'hire', 'connect', 'message'],
      responseGenerator: _contactResponse,
      followUpSuggestions: ['LinkedIn', 'GitHub', 'Resume'],
    ),

    // Resume
    _ChatIntent(
      keywords: ['resume', 'cv', 'download'],
      responseGenerator: _resumeResponse,
      followUpSuggestions: ['Contact', 'Experience', 'Skills'],
    ),

    // Location
    _ChatIntent(
      keywords: ['where', 'location', 'based', 'live', 'city', 'country'],
      responseGenerator: _locationResponse,
      followUpSuggestions: ['Contact', 'About', 'Experience'],
    ),

    // Social / LinkedIn / GitHub
    _ChatIntent(
      keywords: ['github', 'linkedin', 'social', 'profile'],
      responseGenerator: _socialResponse,
      followUpSuggestions: ['Contact', 'Projects', 'Resume'],
    ),

    // Thanks
    _ChatIntent(
      keywords: ['thank', 'thanks', 'bye', 'goodbye'],
      responseGenerator: _thanksResponse,
      followUpSuggestions: initialSuggestions,
    ),
  ];

  // ── Response generators ──────────────────────────────────────────────────

  static String _greetingResponse() {
    return '''Hello! 👋 Welcome to ${PortfolioData.firstName}'s portfolio!

I'm here to help you learn more about Hasnain — a ${PortfolioData.title} based in ${PortfolioData.location}.

What would you like to know?''';
  }

  static String _aboutResponse() {
    return '''${PortfolioData.firstName} is a ${PortfolioData.title} based in ${PortfolioData.location}.

${PortfolioData.heroDescription}

Hasnain is currently building his career at RH POS and is passionate about writing clean, maintainable code that creates real impact.''';
  }

  static String _skillsResponse() {
    final topSkills = PortfolioData.skills
        .where((s) => s.level >= 75)
        .take(6)
        .map((s) => '${s.icon} ${s.name}')
        .join('\n');

    return '''Here are the top skills:

$topSkills

Expertise spans ${PortfolioData.skills.length}+ technologies across Flutter development, databases, backend, and tools!''';
  }

  static String _flutterResponse() {
    return '''Flutter is the primary expertise! 💙

• Building cross-platform apps for Android, iOS & Web
• Proficient in GetX and Provider state management
• REST API integration & Firebase backend
• Clean architecture & modular code structure
• Custom UI & animations

Technologies: Flutter, Dart, GetX, Provider, Firebase''';
  }

  static String _stateManagementResponse() {
    final stateSkills = PortfolioData.skills
        .where((s) => s.category == 'State Management')
        .map((s) => '${s.icon} ${s.name} - ${s.level}%')
        .join('\n');

    return '''State Management expertise:

$stateSkills

GetX is the preferred choice for its simplicity and performance in production apps.''';
  }

  static String _experienceResponse() {
    final currentJob = PortfolioData.experiences.first;

    return '''Work Experience:

🏢 Current: ${currentJob.role}
📍 ${currentJob.company} — ${currentJob.location}
📅 ${currentJob.duration}

Working on a cross-platform POS system using Flutter, GetX, and ObjectBox with REST API integrations.

Total professional experience: ~1 year in Flutter development.''';
  }

  static String _projectsResponse() {
    final projectList = PortfolioData.projects
        .take(4)
        .map((p) => '• ${p.title} - ${p.subtitle}')
        .join('\n');

    return '''Notable Projects (${PortfolioData.projects.length} total):

$projectList

Ask about any specific project for more details!''';
  }

  static String _specificProjectResponse(String projectName) {
    final project = PortfolioData.projects.firstWhere(
      (p) => p.title.toLowerCase().contains(projectName.toLowerCase()),
      orElse: () => PortfolioData.projects.first,
    );

    return '''${project.title} — ${project.subtitle}

${project.description.trim().split('\n').first}

Technologies: ${project.technologies.join(', ')}

Key Features:
${project.highlights.map((h) => '• $h').join('\n')}''';
  }

  static String _educationResponse() {
    final eduList = PortfolioData.education
        .map((e) => '🎓 ${e.degree}\n   ${e.institution}\n   ${e.duration}')
        .join('\n\n');

    return '''Education Background:

$eduList''';
  }

  static String _contactResponse() {
    return '''Contact Information:

📧 Email: ${PortfolioData.email}
📱 Phone: ${PortfolioData.phone}
📍 Location: ${PortfolioData.location}

🔗 LinkedIn: ${PortfolioData.linkedIn}
💻 GitHub: ${PortfolioData.github}

Feel free to reach out for collaborations or opportunities!''';
  }

  static String _resumeResponse() {
    return '''You can download the resume from:

📄 ${PortfolioData.resumeUrl}

The resume includes detailed information about skills, experience, and projects.''';
  }

  static String _locationResponse() {
    return '''${PortfolioData.firstName} is based in ${PortfolioData.location}.

Currently working as a ${PortfolioData.title} at RH POS.

Open to remote and hybrid opportunities!''';
  }

  static String _socialResponse() {
    return '''Social & Professional Links:

🔗 LinkedIn: ${PortfolioData.linkedIn}
💻 GitHub: ${PortfolioData.github}

Connect to see more work and updates!''';
  }

  static String _thanksResponse() {
    return '''You're welcome! 😊

Feel free to explore more about ${PortfolioData.firstName}'s work or reach out through the contact section.

Have a great day!''';
  }

  static String _fallbackResponse() {
    return '''I'm not sure I understood that. Here are some things you can ask:

• Who is Hasnain?
• What are your skills?
• Tell me about your projects
• What's your experience?
• How can I contact you?

Feel free to ask anything about the portfolio!''';
  }
}

/// Chat response with message and suggestions
class ChatResponse {
  final String message;
  final List<String> suggestions;

  const ChatResponse({
    required this.message,
    required this.suggestions,
  });
}

/// Internal intent class for pattern matching
class _ChatIntent {
  final List<String> keywords;
  final String Function() responseGenerator;
  final List<String> followUpSuggestions;

  const _ChatIntent({
    required this.keywords,
    required this.responseGenerator,
    required this.followUpSuggestions,
  });
}
