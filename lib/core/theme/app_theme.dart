import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Hasnain Patel Portfolio Theme
/// Modern Cyber-Teal Dark Theme — Electric Blue + Teal + Deep Black
class AppTheme {
  // ─── Primary Palette ──────────────────────────────────────────────────────
  static const Color primaryElectric = Color(0xFF00D4FF); // Electric Cyan
  static const Color primaryMagic = primaryElectric; // Alias for backward compat
  static const Color secondaryTeal   = Color(0xFF00F5C4); // Emerald Teal
  static const Color accentViolet   = Color(0xFF7C3AED); // Deep Violet
  static const Color accentBlueGlow = Color(0xFF3B82F6); // Blue Glow
  static const Color neonMint        = Color(0xFF10FFCB); // Neon Mint
  
  // Aliases for backward compatibility
  static const Color secondaryMagic = secondaryTeal;
  static const Color accentCyan = primaryElectric;
  static const Color accentPink = accentViolet;
  static const Color cosmicIndigo = darkBg;

  // ─── Dark Background Layers ───────────────────────────────────────────────
  static const Color darkBg      = Color(0xFF050B14); // Near black navy
  static const Color darkCard    = Color(0xFF0D1526); // Card surface
  static const Color darkSurface = Color(0xFF0A1120); // Slightly lighter bg
  static const Color darkBorder  = Color(0xFF1A2A40); // Subtle border

  // ─── Light Theme ──────────────────────────────────────────────────────────
  static const Color lightBg      = Color(0xFFF0F9FF);
  static const Color lightCard    = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFE0F2FE);

  // ─── Text Colors ──────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFEFF6FF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted     = Color(0xFF475569);
  static const Color textDark      = Color(0xFF0F172A);

  // ─── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryElectric, secondaryTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Aliases for backward compatibility
  static const LinearGradient magicGradient = primaryGradient;
  static const LinearGradient neonGradient = primaryGradient;

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF050B14), Color(0xFF071220), Color(0xFF050B14)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0D1526), Color(0xFF101B30)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentViolet, primaryElectric, secondaryTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glowGradient = LinearGradient(
    colors: [primaryElectric, neonMint],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ─── Dark Theme ───────────────────────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,

    colorScheme: const ColorScheme.dark(
      primary: primaryElectric,
      secondary: secondaryTeal,
      surface: darkSurface,
      error: Color(0xFFEF4444),
      onPrimary: Color(0xFF050B14),
      onSecondary: Color(0xFF050B14),
      onSurface: textPrimary,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        letterSpacing: -2,
        height: 1.05,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        letterSpacing: -1,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        height: 1.75,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        height: 1.65,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: textSecondary,
      ),
      labelLarge: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: 1.5,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 1.2,
      ),
    ),

    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: darkBorder, width: 1),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryElectric,
        foregroundColor: const Color(0xFF050B14),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.spaceGrotesk(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: darkBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: darkBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryElectric, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      hintStyle: GoogleFonts.inter(color: textMuted, fontSize: 15),
    ),
  );

  // ─── Light Theme ──────────────────────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBg,
    colorScheme: const ColorScheme.light(
      primary: accentViolet,
      secondary: primaryElectric,
      surface: lightSurface,
      onPrimary: Colors.white,
      onSurface: textDark,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: textDark,
        letterSpacing: -2,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 17, color: textMuted, height: 1.7),
    ),
  );
}

// ─── Glassmorphism Container ─────────────────────────────────────────────────
BoxDecoration glassDecoration({
  Color? color,
  double blur = 20,
  double opacity = 0.07,
  double borderOpacity = 0.12,
  double borderRadius = 20,
}) {
  return BoxDecoration(
    color: (color ?? AppTheme.primaryElectric).withOpacity(opacity),
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(
      color: AppTheme.primaryElectric.withOpacity(borderOpacity),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppTheme.primaryElectric.withOpacity(0.07),
        blurRadius: blur,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

// ─── Neon Glow Effect ────────────────────────────────────────────────────────
BoxDecoration neonGlow({
  required Color color,
  double blurRadius = 28,
  double spreadRadius = 2,
}) {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: color.withOpacity(0.5),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: color.withOpacity(0.2),
        blurRadius: blurRadius * 2.5,
        spreadRadius: spreadRadius,
      ),
    ],
  );
}

// ─── Cyber Card Decoration ───────────────────────────────────────────────────
BoxDecoration cyberCard({
  double borderRadius = 18,
  bool isHovered = false,
  bool hasPrimaryAccent = false,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isHovered
          ? [const Color(0xFF112035), const Color(0xFF0A1828)]
          : [const Color(0xFF0D1526), const Color(0xFF091220)],
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(
      color: isHovered
          ? AppTheme.primaryElectric.withOpacity(0.5)
          : hasPrimaryAccent
              ? AppTheme.primaryElectric.withOpacity(0.25)
              : AppTheme.darkBorder,
      width: isHovered ? 1.5 : 1,
    ),
    boxShadow: isHovered
        ? [
            BoxShadow(
              color: AppTheme.primaryElectric.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
  );
}

// ─── Skill Bar Fill ──────────────────────────────────────────────────────────
BoxDecoration skillBarFill({Color? color, double borderRadius = 6}) {
  final fillColor = color ?? AppTheme.primaryElectric;
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [fillColor, AppTheme.secondaryTeal],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: fillColor.withOpacity(0.4),
        blurRadius: 8,
        spreadRadius: 0,
      ),
    ],
  );
}

// ─── Legacy Aliases (kept for backward compat with existing widgets) ──────────
BoxDecoration skeuomorphicCard({
  Color? baseColor,
  double borderRadius = 18,
  bool isPressed = false,
  bool hasInnerShadow = true,
}) => cyberCard(borderRadius: borderRadius, isHovered: isPressed);

BoxDecoration skeuomorphicButton({
  Color? baseColor,
  double borderRadius = 12,
  bool isPressed = false,
  bool isPrimary = true,
}) {
  final color = baseColor ??
      (isPrimary ? AppTheme.primaryElectric : const Color(0xFF1A2A40));
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isPressed
          ? [
              Color.lerp(color, Colors.black, 0.2)!,
              color,
            ]
          : [
              Color.lerp(color, Colors.white, 0.15)!,
              color,
            ],
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(
      color: color.withOpacity(0.4),
      width: 1.5,
    ),
    boxShadow: isPressed
        ? []
        : [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
  );
}

BoxDecoration skeuomorphicInset({Color? baseColor, double borderRadius = 12}) {
  final color = baseColor ?? AppTheme.darkCard;
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: AppTheme.darkBorder, width: 1),
  );
}

BoxDecoration skeuomorphicTrack({double borderRadius = 8}) {
  return BoxDecoration(
    color: const Color(0xFF0D1526),
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: AppTheme.darkBorder, width: 1),
  );
}

BoxDecoration skeuomorphicProgressFill({
  Color? color,
  double borderRadius = 6,
}) => skillBarFill(color: color, borderRadius: borderRadius);

BoxDecoration skeuomorphicBadge({bool isCircle = true, Color? baseColor}) {
  final color = baseColor ?? AppTheme.primaryElectric;
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    borderRadius: isCircle ? null : BorderRadius.circular(10),
    gradient: LinearGradient(
      colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(color: color.withOpacity(0.4), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: color.withOpacity(0.25),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ],
  );
}

// ─── Kept for any widget referencing SkeuomorphicColors ──────────────────────
class SkeuomorphicColors {
  static const Color richBrown       = Color(0xFF5D4037);
  static const Color warmTan         = Color(0xFF8D6E63);
  static const Color deepBronze      = Color(0xFF795548);
  static const Color copperAccent    = Color(0xFFB87333);
  static const Color brushedSilver   = Color(0xFFB0B0B0);
  static const Color polishedSteel   = Color(0xFF78909C);
  static const Color darkMetal       = Color(0xFF37474F);
  static const Color goldAccent      = Color(0xFFD4AF37);
  static const Color darkWalnut      = Color(0xFF3E2723);
  static const Color mahogany        = Color(0xFF4E342E);
  static const Color oakWood         = Color(0xFF6D4C41);
  static const Color cherryWood      = Color(0xFF5D4037);
  static const Color bgDark          = Color(0xFF050B14);
  static const Color bgMedium        = Color(0xFF0D1526);
  static const Color bgLight         = Color(0xFF1A2A40);
  static const Color highlightWhite  = Color(0xFFFFFFFF);
  static const Color shadowBlack     = Color(0xFF000000);
  static const Color accentBlue      = Color(0xFF00D4FF);
  static const Color accentGreen     = Color(0xFF00F5C4);
  static const Color accentRed       = Color(0xFFEF4444);
  static const Color accentOrange    = Color(0xFFF97316);
}

class SkeuomorphicGradients {
  static LinearGradient brushedMetal = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF0D1526),
      const Color(0xFF112035),
      const Color(0xFF0A1828),
      const Color(0xFF112035),
      const Color(0xFF0D1526),
    ],
    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
  );

  static LinearGradient darkLeather = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D1526), Color(0xFF091220), Color(0xFF050B14)],
  );

  static LinearGradient polishedWood = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF112035), Color(0xFF0D1526), Color(0xFF091220), Color(0xFF0D1526)],
    stops: [0.0, 0.4, 0.6, 1.0],
  );

  static LinearGradient buttonPressed = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A1828), Color(0xFF0D1F35), Color(0xFF122540)],
  );

  static LinearGradient buttonRaised = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF122540), Color(0xFF0D1F35), Color(0xFF0A1828)],
  );
}
