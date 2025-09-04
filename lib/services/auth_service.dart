import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      try {
        final userData = Map<String, dynamic>.from(
          // ignore: unnecessary_null_comparison
          userJson != null ? json.decode(userJson) : {},
        );
        _currentUser = User.fromJson(userData);
        notifyListeners();
      } catch (e) {
        // Invalid stored user data, clear it
        await prefs.remove('user');
      }
    }
  }

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

      // Save user data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(_currentUser!.toJson()));

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

      // Save user data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(_currentUser!.toJson()));

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  Future<bool> updateProfilePicture(String imagePath) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement actual image upload logic with your backend
      // This is just a mock implementation
      await Future.delayed(const Duration(seconds: 1));

      // Create a new user object with updated profile picture
      _currentUser = User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        name: _currentUser!.name,
        profilePicture: imagePath,
        createdAt: _currentUser!.createdAt,
      );

      // Update stored user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(_currentUser!.toJson()));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
