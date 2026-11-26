class AppConstants {
  AppConstants._();

  static const String appName = 'Hopkid';
  static const String appSubtitle = 'by Little Laugh';
  static const String splashTagline = "Kids' Fashion, Toys & Daily Essentials";
  static const String currencySymbol = '₹';

  // Configure via --dart-define=API_BASE_URL=https://api.hopkid.in/v1
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static const Duration apiTimeout = Duration(seconds: 15);
  static const String tokenStorageKey = 'hopkid_auth_token';
  static const String refreshTokenKey = 'hopkid_refresh_token';
  static const String onboardingSeenKey = 'hopkid_onboarding_seen';
  static const String cartStorageKey = 'hopkid_local_cart';
}
