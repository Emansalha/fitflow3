import 'package:flutter/material.dart';

class AppColors {
  static const mint = Color(0xFF2F9E78);
  static const mintDark = Color(0xFF2F7F63);
  static const mintLight = Color(0xFFD6F3E7);
  static const peach = Color(0xFFE9835A);
  static const peachDark = Color(0xFFC4623A);
  static const peachLight = Color(0xFFFFE9DC);
  static const ink = Color(0xFF1F2E2A);
  static const muted = Color(0xFF3C5149);
  static const barIdle = Color(0xFFB7DDCE);
  static const trackMint = Color(0xFFCDE8DD);
  static const trackPeach = Color(0xFFF9D2BC);
}

const kGlassFill = Color(0xA6FFFFFF);
const kGlassBorder = Color(0xE6FFFFFF);

class AppText {
  static const title = TextStyle(
      fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.15);
  static const heading = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink);
  static const body = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink);
  static const caption = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.muted);
}

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mint),
    scaffoldBackgroundColor: Colors.transparent,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: kGlassFill,
      indicatorColor: AppColors.mintLight,
      elevation: 0,
      labelTextStyle: WidgetStateProperty.all(const TextStyle(
          fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.ink)),
    ),
  );
}

String formatNumber(num n) {
  final s = n.round().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return b.toString();
}
