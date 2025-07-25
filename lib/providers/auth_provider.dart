import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_3/repository/auth_repository.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

class AuthNotifier extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(false) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    state = await _authRepository.isLoggedIn();
  }

  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    await _authRepository.saveSession(email);
    state = true;
  }

  Future<void> signOut() async {
    await _authRepository.clearSession();
    state = false;
  }
}