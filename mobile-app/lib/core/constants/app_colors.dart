import 'package:material_ui/material_ui.dart';

class AppColors {
  AppColors._();

  static const Color primaryPurple = Color(0xFF6A0DAD);
  static const Color deepPurple = Color(0xFF4B087E);
  static const Color gradientStart = Color(0xFF7B18C8);
  static const Color gradientEnd = Color(0xFF570AA3);
  static const Color lightPurple = Color(0xFFF4EAFE);
  static const Color lavender = Color(0xFFEDE0FA);
  static const Color pink = Color(0xFFFCE7F3);
  static const Color lightBackground = Color(0xFFFCFAFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF1C1530);
  static const Color secondaryText = Color(0xFF6B6478);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color border = Color(0xFFE8E2F0);
  static const Color bluePastel = Color(0xFFE8F2FF);
  static const Color greenPastel = Color(0xFFE7F8EA);
  static const Color orangePastel = Color(0xFFFFF3DF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
