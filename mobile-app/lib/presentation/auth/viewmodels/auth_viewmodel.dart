import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/providers.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final bool isSignupMode;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.isSignupMode = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    bool? isSignupMode,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isSignupMode: isSignupMode ?? this.isSignupMode,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  void toggleMode(bool isSignup) {
    state = state.copyWith(isSignupMode: isSignup, clearError: true);
  }

  Future<bool> login(String identifier, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref
          .read(authRepositoryProvider)
          .login(identifier: identifier, password: password);
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      return true;
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to sign in. Please try again.',
      );
      return false;
    }
  }

  Future<bool> signup(String name, String identifier, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref
          .read(authRepositoryProvider)
          .signup(name: name, identifier: identifier, password: password);
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      return true;
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to create account. Please try again.',
      );
      return false;
    }
  }

  Future<bool> continueWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true);
    await ref.read(authRepositoryProvider).loginWithGoogle();
    state = state.copyWith(isLoading: false, isAuthenticated: true);
    return true;
  }

  Future<bool> continueWithApple() async {
    state = state.copyWith(isLoading: true, clearError: true);
    await ref.read(authRepositoryProvider).loginWithApple();
    state = state.copyWith(isLoading: false, isAuthenticated: true);
    return true;
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState();
  }
}

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);
