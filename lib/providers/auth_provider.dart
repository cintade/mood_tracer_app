import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model UserProfile disimpan di sini jika tidak dipisahkan ke file sendiri
class UserProfile {
  String name;
  String username;
  String bio;
  String phoneNumber;
  String gender;
  String birthDate;

  UserProfile({
    this.name = 'User Baru',
    this.username = 'userbaru99',
    this.bio = 'Pengguna aplikasi Mood Tracer.',
    this.phoneNumber = 'Belum ditambahkan',
    this.gender = 'Belum diatur',
    this.birthDate = 'Belum diatur',
  });
}

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _currentUserEmail;

  static final Map<String, String> _users = {
    'test@gmail.com': '123456',
  };

  static final Map<String, UserProfile> _userProfiles = {
    'test@gmail.com': UserProfile(),
  };

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserEmail => _currentUserEmail;
  UserProfile? get currentUserProfile => _userProfiles[_currentUserEmail];

  static const String _baseUrl = 'http://localhost:3000';

  // 🔐 Login
  Future<String?> signIn(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (res.statusCode == 200) {
        _isAuthenticated = true;
        _currentUserEmail = email;
        _userProfiles.putIfAbsent(email, () => UserProfile());
        notifyListeners();
        return null;
      } else {
        final message =
            jsonDecode(res.body)['message'] ?? 'Email/password salah';
        return 'Login gagal: $message';
      }
    } catch (e) {
      return 'Terjadi kesalahan saat login: $e';
    }
  }

  // 📝 Sign Up
  Future<String?> signUp(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$_baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (res.statusCode == 200) {
        _users[email] = password;
        _userProfiles[email] = UserProfile();
        _isAuthenticated = true;
        _currentUserEmail = email;
        notifyListeners();
        return null;
      } else {
        final message = jsonDecode(res.body)['message'] ?? 'Gagal mendaftar';
        return 'Sign Up gagal: $message';
      }
    } catch (e) {
      return 'Terjadi kesalahan saat sign up: $e';
    }
  }

  // 🚪 Logout
  Future<void> signOut() async {
    _isAuthenticated = false;
    _currentUserEmail = null;
    notifyListeners();
  }

  // ❌ Hapus akun lokal
  Future<void> deleteAccount() async {
    if (_currentUserEmail != null) {
      _users.remove(_currentUserEmail);
      _userProfiles.remove(_currentUserEmail);
      _isAuthenticated = false;
      _currentUserEmail = null;
      notifyListeners();
    }
  }

  // 🛠 Update profil
  void updateProfile(UserProfile newProfile) {
    if (_currentUserEmail != null) {
      _userProfiles[_currentUserEmail!] = newProfile;
      notifyListeners();
    }
  }
}
