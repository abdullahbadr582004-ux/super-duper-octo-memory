import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final _storage = const FlutterSecureStorage();
  static const _sessionKey = 'user_session';

  Future<void> saveSession(String email) async {
    await _storage.write(key: _sessionKey, value: email);
  }

  bool isLoggedInSync = false;

  Future<bool> isLoggedIn() async {
    final session = await _storage.read(key: _sessionKey);
    isLoggedInSync = session != null;
    return session != null;
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _sessionKey);
    isLoggedInSync = false;
  }
}
