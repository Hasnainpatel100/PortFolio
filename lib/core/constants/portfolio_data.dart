/// Portfolio Data - Hasnain Noorulla Patel
class PortfolioData {
  // Personal Information
  static const String fullName = 'Hasnain Patel';
  static const String firstName = 'Hasnain';
  static const String lastName = 'Patel';
  static const String title = 'Flutter Developer | Full Stack Developer';
  static const String location = 'Latur, India';
  static const String email = 'patelhusnain01@gmail.com';
  static const String phone = '+918767527475';
  static const String whatsappNumber = '918767527475'; // Without + for WhatsApp
  static const String dateOfBirth = '30-05-2005';

  // Social Links
  static const String linkedIn =
      'https://www.linkedin.com/in/hasnain-patel-089579260/';
  static const String github = 'https://github.com/Hasnainpatel100/';
  static const String portfolio = 'https://github.com/Hasnainpatel100/';

  // Profile Image
  static const String profileImage =
      'assets/images/Hasnain.png'; // Your uploaded photo
  static const String resumeUrl =
      'https://drive.google.com/open?id=1hZr7jl_riD4necWbCTf3INbS1MnZOT-m&usp=drive_fs';

  // Hero Section
  static const String heroTagline = 'Building Digital Experiences 🚀';
  static const String heroSubtitle =
      'Crafting elegant Flutter apps & full-stack solutions';
  static const String heroDescription =
      'Passionate Flutter Developer & Full Stack enthusiast from Latur, India. I turn ideas into polished, cross-platform mobile and web applications — with clean code, beautiful UI, and rock-solid performance.';

  // About Me
  static const String aboutMe = '''
I am a dedicated Flutter Developer and Full Stack Developer with a passion for building seamless, high-quality digital experiences. I specialize in cross-platform mobile development with Flutter/Dart, and have hands-on experience with backend technologies like Node.js, MongoDB, and MySQL.

I take pride in writing clean, modular, and maintainable code. Whether it's designing pixel-perfect UIs, integrating REST APIs, or managing complex application state, I ensure every component is built with performance and scalability in mind.

Currently growing at RH POS, I am continuously expanding my skill set and delivering real-world solutions that make an impact. I am eager to collaborate on exciting projects and bring ideas to life.
''';

  // Skills with proficiency
  static const List<SkillData> skills = [
    // Mobile Development
    SkillData(
      name: 'Flutter',
      category: 'Mobile Development',
      level: 80,
      icon: '💙',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'Dart',
      category: 'Languages',
      level: 75,
      icon: '🎯',
      yearsOfExperience: 1,
    ),

    // Languages
    SkillData(
      name: 'JavaScript',
      category: 'Languages',
      level: 50,
      icon: '💛',
      yearsOfExperience: 1,
    ),

    // State Management
    SkillData(
      name: 'GetX',
      category: 'State Management',
      level: 80,
      icon: '🚀',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'Provider',
      category: 'State Management',
      level: 70,
      icon: '⚡',
      yearsOfExperience: 1,
    ),

    // Databases
    SkillData(
      name: 'MongoDB',
      category: 'Database',
      level: 70,
      icon: '🍃',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'MySQL',
      category: 'Database',
      level: 70,
      icon: '🐬',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'ObjectBox',
      category: 'Database',
      level: 75,
      icon: '📦',
      yearsOfExperience: 1,
    ),

    // Backend
    SkillData(
      name: 'REST APIs',
      category: 'Backend',
      level: 50,
      icon: '🔗',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'Node.js',
      category: 'Backend',
      level: 40,
      icon: '💚',
      yearsOfExperience: 1,
    ),

    // Tools
    SkillData(
      name: 'Git & GitHub',
      category: 'Tools',
      level: 75,
      icon: '🐙',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'Firebase',
      category: 'Tools',
      level: 50,
      icon: '🔥',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'Postman',
      category: 'Tools',
      level: 50,
      icon: '📮',
      yearsOfExperience: 1,
    ),
    SkillData(
      name: 'Android Studio',
      category: 'Tools',
      level: 80,
      icon: '🤖',
      yearsOfExperience: 1,
    ),
  ];

  // Experience Timeline
  static const List<ExperienceData> experiences = [
    ExperienceData(
      company: 'RH POS',
      role: 'Flutter Developer',
      location: 'Latur, India',
      duration: 'June 2025 – Present',
      startDate: '2025-06',
      endDate: 'Present',
      description: '''
Working as a Flutter Developer building a full-featured Point of Sale system.

• Developing cross-platform POS app using Flutter and GetX state management
• Integrating REST APIs for inventory, billing, and sales management workflows
• Implementing ObjectBox local database for offline-first functionality
• Collaborating with the team to deliver clean, production-ready features
• Continuously learning and applying industry best practices in every sprint
''',
      technologies: [
        'Flutter',
        'Dart',
        'GetX',
        'ObjectBox',
        'REST APIs',
        'MySQL',
      ],
    ),
  ];

  // Projects
  static const List<ProjectData> projects = [
    ProjectData(
      title: 'Restaurant Management App',
      subtitle: 'Cross-Platform Management System',
      description: '''
Designed & developed a cross-platform restaurant management system with a clean, modular architecture and ObjectBox local database.

Implemented core workflows: Dashboard, KOT (Kitchen Order Ticket), Billing, and KDS (Kitchen Display System). Built advanced modules including bill splitting, multiple order types, accounts management, reporting, and printer configuration (Bluetooth & Network printers). Added features for bill/KOT reset and multi-language support (English, Hindi, Arabic).
''',
      technologies: [
        'Flutter',
        'ObjectBox',
        'Cross-Platform',
        'Bluetooth Printing',
      ],
      category: 'Professional',
      imageUrl: 'assets/images/restaurant_app.png',
      demoUrl: null,
      githubUrl: 'https://github.com/Hasnainpatel100/',
      highlights: [
        'Modular Clean Architecture',
        'Offline-first ObjectBox database',
        'KOT, Billing & KDS modules',
        'Bluetooth & Network printer integrations',
        'Multi-language (EN, HI, AR)',
      ],
    ),
    ProjectData(
      title: 'Supermarket POS & Inventory Management System',
      subtitle: 'High-Performance POS System',
      description: '''
Built a high-performance POS and inventory management system using Flutter, GetX, and ObjectBox.

Designed an offline-first architecture to ensure uninterrupted operations during network outages. Developed key modules including POS billing, stock control, vendor management, returns, and reporting. Intregrated barcode scanning, hold/resume cart functionality, and rapid checkout workflows. Created interactive dashboards for sales trends, profit/loss analysis, and expense tracking.
''',
      technologies: [
        'Flutter',
        'GetX',
        'ObjectBox',
        'Offline-First',
      ],
      category: 'Professional',
      imageUrl: 'assets/images/supermarket_app.png',
      demoUrl: null,
      githubUrl: 'https://github.com/Hasnainpatel100/',
      highlights: [
        'Offline-first resilient architecture',
        'Billing, stock & vendor management',
        'Barcode scanning & rapid checkout workflows',
        'Interactive analytics dashboards',
      ],
    ),
    ProjectData(
      title: 'NASA Fire Safety',
      subtitle: 'Digital Product Showcase Platform',
      description: '''
Developed a high-performance, single-page promotional web app for fire-safety equipment using Flutter and GetX.

Engineered a fully responsive UI that adapts seamlessly across mobile, tablet, and desktop devices. Implemented custom theme management (Dark/Light mode) and smooth scroll navigation to enhance user experience. Built a modular architecture with reusable widgets to display complex product catalogs for clean-agent systems.
''',
      technologies: ['Flutter', 'GetX', 'Responsive Web'],
      category: 'Professional',
      imageUrl: 'assets/images/fire_safety_app.png',
      demoUrl: null,
      githubUrl: 'https://github.com/Hasnainpatel100/',
      highlights: [
        'Fully responsive Web design',
        'Custom theme management',
        'Modular catalog UI',
        'Smooth scroll navigation',
      ],
    ),
    ProjectData(
      title: 'Cookify - Smart Recipe Finder',
      subtitle: 'Interactive Web Application',
      description: '''
Developed an interactive web application that lets users search, filter, and explore recipes based on ingredients and cuisine.

Implemented dynamic data handling using JSON to store recipe details and enable instant search results without page reloads. Enhanced user experience with intuitive navigation, categorized recipe listings, and a visually appealing UI design.
''',
      technologies: ['Flutter', 'Web', 'JSON', 'Dynamic UI'],
      category: 'Personal',
      imageUrl: 'assets/images/cookify_app.png',
      demoUrl: null,
      githubUrl: 'https://github.com/Hasnainpatel100/',
      highlights: [
        'Interactive filtering',
        'Instant search results without reload',
        'Categorized listings',
        'Visually appealing UI',
      ],
    ),
  ];

  // Education
  static const List<EducationData> education = [
    EducationData(
      institution: 'Yashwantrao Chavan College of Engineering, Latur',
      degree: 'B.E. in Computer Science & Engineering',
      duration: '2023 – 2027 (Ongoing)',
      description: 'Bachelor of Engineering in Computer Science',
    ),
    EducationData(
      institution: 'Government Polytechnic, Latur',
      degree: 'Diploma in Computer Engineering',
      duration: '2021 – 2023',
      description: 'Diploma in Computer Engineering',
    ),
    EducationData(
      institution: 'High School, Latur',
      degree: 'SSC (10th Standard)',
      duration: 'Completed 2020',
      description: 'Secondary School Certificate',
    ),
  ];
}

// Data Models
class SkillData {
  final String name;
  final String category;
  final int level; // 0-100
  final String icon;
  final int yearsOfExperience;

  const SkillData({
    required this.name,
    required this.category,
    required this.level,
    required this.icon,
    this.yearsOfExperience = 0,
  });
}

class ExperienceData {
  final String company;
  final String role;
  final String location;
  final String duration;
  final String startDate;
  final String endDate;
  final String description;
  final List<String> technologies;

  const ExperienceData({
    required this.company,
    required this.role,
    required this.location,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.technologies,
  });
}

class ProjectData {
  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final String category;
  final String imageUrl;
  final String? demoUrl;
  final String? githubUrl;
  final List<String> highlights;

  const ProjectData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.technologies,
    required this.category,
    required this.imageUrl,
    this.demoUrl,
    this.githubUrl,
    required this.highlights,
  });
}

class EducationData {
  final String institution;
  final String degree;
  final String duration;
  final String description;

  const EducationData({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.description,
  });
}
