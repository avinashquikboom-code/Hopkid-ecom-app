abstract class AuthRepository {
  Future<bool> hasActiveSession();
  Future<bool> hasSeenOnboarding();
  Future<void> markOnboardingSeen();
  Future<void> login({required String identifier, required String password});
  Future<void> signup({
    required String name,
    required String identifier,
    required String password,
  });
  Future<void> loginWithGoogle();
  Future<void> loginWithApple();
  Future<void> logout();
}
