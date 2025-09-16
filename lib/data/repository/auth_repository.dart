import '../../core/utils/shared_prefs_storage.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository(this.service);

  Future<void> login(String username, String password) async {
    final token = await service.login(username, password);
    await SharedPrefsStorage.saveToken(token);
  }

  Future<bool> isLoggedIn() async {
    final token = await SharedPrefsStorage.getToken();
    return token != null;
  }
}
