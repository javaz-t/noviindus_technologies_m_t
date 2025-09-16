import 'package:flutter/material.dart';
import '../../data/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthProvider(this.repository);

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.login(username, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> checkLogin() async {
    return await repository.isLoggedIn();
  }
}
