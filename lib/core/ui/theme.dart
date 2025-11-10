import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

// Light Color Scheme
final lightColorScheme = ColorScheme.light(
  primary: m3Primary,
  onPrimary: m3OnPrimary,
  primaryContainer: m3PrimaryContainer,
  onPrimaryContainer: m3OnPrimaryContainer,

  secondary: purple67,
  onSecondary: white,
  secondaryContainer: m3SecondaryContainer,
  onSecondaryContainer: m3OnSecondaryContainer,

  tertiary: mainYellow,
  onTertiary: black,
  tertiaryContainer: yellowEB,
  onTertiaryContainer: purple1D,

  error: redE6,
  onError: white,
  errorContainer: const Color(0xFFFFDAD6),
  onErrorContainer: const Color(0xFF410002),

  surface: white,
  onSurface: m3OnSurface,

  outline: m3OutlineVariant,
  outlineVariant: grayE0,

  scrim: black,
  inverseSurface: purple1D,
  onInverseSurface: white,
  inversePrimary: purpleEA,

  surfaceTint: m3Primary,
);

// Dark Color Scheme
final darkColorScheme = ColorScheme.dark(
  primary: purpleEA,
  onPrimary: purple4F,
  primaryContainer: purple67,
  onPrimaryContainer: purpleEA,

  secondary: purpleE8,
  onSecondary: purple4A,
  secondaryContainer: purple4A,
  onSecondaryContainer: purpleE8,

  tertiary: yellowE8,
  onTertiary: yellow7E,
  tertiaryContainer: yellow7E,
  onTertiaryContainer: yellowEB,

  error: const Color(0xFFFFB4AB),
  onError: const Color(0xFF690005),
  errorContainer: const Color(0xFF93000A),
  onErrorContainer: const Color(0xFFFFDAD6),

  surface: purple1D,
  onSurface: white,

  outline: gray808,
  outlineVariant: purple49,

  scrim: black,
  inverseSurface: grayE6,
  onInverseSurface: purple1D,
  inversePrimary: purple67,

  surfaceTint: purpleEA,
);

// Typography usando Google Fonts
final appTextTheme = TextTheme(
  // Usando Source Sans Pro como fuente principal
  displayLarge: GoogleFonts.sourceSans3(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
  ),
  displayMedium: GoogleFonts.sourceSans3(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
  ),
  displaySmall: GoogleFonts.sourceSans3(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
  ),
  headlineLarge: GoogleFonts.sourceSans3(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
  ),
  headlineMedium: GoogleFonts.sourceSans3(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
  ),
  headlineSmall: GoogleFonts.sourceSans3(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
  ),
  titleLarge: GoogleFonts.sourceSans3(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  ),
  titleMedium: GoogleFonts.sourceSans3(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.sourceSans3(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.sourceSans3(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.sourceSans3(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  ),
  bodySmall: GoogleFonts.sourceSans3(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  ),
  labelLarge: GoogleFonts.sourceSans3(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
  ),
  labelMedium: GoogleFonts.sourceSans3(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.5,
  ),
  labelSmall: GoogleFonts.sourceSans3(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.5,
  ),
);

// Light Theme
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: appTextTheme,
  scaffoldBackgroundColor: white,
);

// Dark Theme
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: appTextTheme,
  scaffoldBackgroundColor: purple1D,
);
