import '../../../core/errors/failures.dart';
import '../../../core/network/api_client.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../datasources/local/hopkid_local_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final HopkidLocalStorage _localStorage;

  AuthRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<bool> hasActiveSession() async {
    final token = await _localStorage.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> hasSeenOnboarding() => _localStorage.hasSeenOnboarding();

  @override
  Future<void> markOnboardingSeen() => _localStorage.setOnboardingSeen();

  @override
  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    if (identifier.trim().isEmpty || password.length < 6) {
      throw const ValidationFailure(
        'Please enter a valid mobile/email and password (min 6 characters).',
      );
    }
    if (_apiClient.isConfigured) {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'identifier': identifier, 'password': password},
      );
      final token = response.data?['accessToken'] as String?;
      if (token != null) {
        await _localStorage.saveTokens(token: token);
        return;
      }
    }
    await _localStorage.saveTokens(token: 'hopkid_session_token');
  }

  @override
  Future<void> signup({
    required String name,
    required String identifier,
    required String password,
  }) async {
    if (name.trim().isEmpty || identifier.trim().isEmpty || password.length < 6) {
      throw const ValidationFailure(
        'Please fill in all fields (password min 6 characters).',
      );
    }
    if (_apiClient.isConfigured) {
      await _apiClient.post<dynamic>(
        '/auth/signup',
        data: {'name': name, 'identifier': identifier, 'password': password},
      );
    }
    await _localStorage.saveTokens(token: 'hopkid_session_token');
  }

  @override
  Future<void> loginWithGoogle() async {
    await _localStorage.saveTokens(token: 'hopkid_google_session');
  }

  @override
  Future<void> loginWithApple() async {
    await _localStorage.saveTokens(token: 'hopkid_apple_session');
  }

  @override
  Future<void> logout() => _localStorage.clearTokens();
}
