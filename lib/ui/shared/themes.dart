import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Shared Colors
const Color primaryColor = Color(0xFF007AFF);
const Color primaryForegroundColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF6C757D);
const Color secondaryForegroundColor = Color(0xFFFFFFFF);
const Color destructiveColor = Color(0xFFDC3545);
const Color destructiveForegroundColor = Color(0xFFFFFFFF);
const Color mutedColor = Color(0xFF6C757D);
const Color mutedForegroundColor = Color(0xFFFFFFFF);
const Color accentColor = Color(0xFF007AFF);
const Color accentForegroundColor = Color(0xFFFFFFFF);
const Color cardColor = Color(0xFFFFFFFF);
const Color cardForegroundColor = Color(0xFF000000);
const Color popoverColor = Color(0xFFFFFFFF);
const Color popoverForegroundColor = Color(0xFF000000);
const Color borderColor = Color(0xFFDEE2E6);
const Color inputColor = Color(0xFFDEE2E6);
const Color ringColor = Color(0xFF007AFF);
const Color backgroundColor = Color(0xFFF8F9FA);
const Color foregroundColor = Color(0xFF212529);

// Shadcn Theme
ShadThemeData buildShadTheme() => ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadSlateColorScheme.light(
        primary: primaryColor,
        primaryForeground: primaryForegroundColor,
        secondary: secondaryColor,
        secondaryForeground: secondaryForegroundColor,
        destructive: destructiveColor,
        destructiveForeground: destructiveForegroundColor,
        muted: mutedColor,
        mutedForeground: mutedForegroundColor,
        accent: accentColor,
        accentForeground: accentForegroundColor,
        cardForeground: cardForegroundColor,
        popoverForeground: popoverForegroundColor,
        border: borderColor,
        input: inputColor,
        ring: ringColor,
        background: backgroundColor,
        foreground: foregroundColor,
      ),
    );

// Cupertino Theme
CupertinoThemeData buildCupertinoTheme() => const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primaryContrastingColor: primaryForegroundColor,
      scaffoldBackgroundColor: backgroundColor,
      barBackgroundColor: backgroundColor,
      textTheme: CupertinoTextThemeData(
        primaryColor: primaryColor,
        textStyle: TextStyle(color: foregroundColor),
        navTitleTextStyle: TextStyle(
          color: foregroundColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        tabLabelTextStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
