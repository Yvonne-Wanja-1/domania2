import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<bool> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement actual signup logic with your backend
      // This is just a mock implementation
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = User(
        id: DateTime.now().toString(),
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement actual signin logic with your backend
      // This is just a mock implementation
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = User(
        id: DateTime.now().toString(),
        email: email,
        createdAt: DateTime.now(),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }
}
