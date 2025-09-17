import 'package:flutter/material.dart';
import '../../data/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  String _userName = '';
  String _userPassword = '';
  void onUserChange(String val) => _userName = val.trim();
  void onPasswordChange(String val) => _userPassword = val.trim();
  bool isDataValid() {
    return _userName.isEmpty && _userPassword.isEmpty;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthProvider(this.repository);

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.login(_userName, _userPassword);
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
