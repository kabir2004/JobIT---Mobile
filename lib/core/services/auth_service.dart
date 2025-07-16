import 'package:flutter/foundation.dart';
import '../../shared/models/user_profile.dart';

class AuthService extends ChangeNotifier {
  UserProfile? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  UserProfile? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  // Simulate checking if user is logged in on app start
  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call to check auth status
    await Future.delayed(const Duration(milliseconds: 500));
    
    // For demo purposes, always start as not authenticated
    _isAuthenticated = false;
    _currentUser = null;
    
    _isLoading = false;
    // Use Future.microtask to avoid setState during build
    Future.microtask(() => notifyListeners());
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, accept any valid email/password
      if (email.isNotEmpty && password.isNotEmpty) {
        _currentUser = UserProfile(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
        );
        _isAuthenticated = true;
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, accept any valid email/password
      if (email.isNotEmpty && password.isNotEmpty) {
        _currentUser = UserProfile(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
        );
        _isAuthenticated = true;
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      _currentUser = updatedProfile;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 300));
    
    _currentUser = null;
    _isAuthenticated = false;
    
    _isLoading = false;
    notifyListeners();
  }
} 