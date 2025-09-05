import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> initializeAuth() async {
    // Check if user is already signed in with Firebase
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      _currentUser = User(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName,
        createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
      );

      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(_currentUser!.toJson()));
      notifyListeners();
    } else {
      // Clear any stored user data if not signed in with Firebase
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      _currentUser = null;
      notifyListeners();
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

      // Create user with email and password in Firebase
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update display name if provided
        if (name != null) {
          await userCredential.user!.updateDisplayName(name);
        }

        _currentUser = User(
          id: userCredential.user!.uid,
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
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } on firebase_auth.FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _currentUser = User(
          id: userCredential.user!.uid,
          email: email,
          name: userCredential.user!.displayName,
          createdAt: DateTime.now(),
        );

        // Save user data to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', json.encode(_currentUser!.toJson()));

        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } on firebase_auth.FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Exception _handleFirebaseAuthError(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return Exception('The email address is not valid.');
      case 'user-disabled':
        return Exception('This user has been disabled.');
      case 'user-not-found':
        return Exception('No user found for that email.');
      case 'wrong-password':
        return Exception('Wrong password provided for that user.');
      case 'email-already-in-use':
        return Exception(
            'The email address is already in use by another account.');
      case 'weak-password':
        return Exception('The password provided is too weak.');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are not enabled.');
      default:
        return Exception('An error occurred. Please try again.');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      notifyListeners();
    } catch (e) {
      throw Exception('Error signing out. Please try again.');
    }
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
