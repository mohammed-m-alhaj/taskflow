import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/database_helper.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  bool _isLoading = false;
  String? _token;
  String? _errorMessage;
  String? _userEmail;
  String? _userName;

  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  bool get isAuthenticated => _token != null;

  Future<bool> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final savedToken = await _storageService.getToken();
      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;
        _apiService.setToken(savedToken);

        final userData = await _storageService.getUserData();
        _userName = userData['name'];
        _userEmail = userData['email'];

        if (savedToken == 'offline_token') {
          _isLoading = false;
          notifyListeners();
          return true;
        }

        try {
          final user = await _apiService.getCurrentUser();
          _userName = user['name'] as String?;
          _userEmail = user['email'] as String?;
          if (_userEmail != null) {
            await _storageService.saveUserData(email: _userEmail!, name: _userName);
          }
          _isLoading = false;
          notifyListeners();
          return true;
        } catch (_) {
          if (_userEmail != null && _userEmail!.isNotEmpty) {
            _isLoading = false;
            notifyListeners();
            return true;
          }
          _token = null;
          _apiService.clearToken();
          await _storageService.clearToken();
        }
      }
    } catch (_) {
      _token = null;
      _apiService.clearToken();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> fetchCurrentUser() async {
    try {
      final user = await _apiService.getCurrentUser();
      _userName = user['name'] as String?;
      _userEmail = user['email'] as String?;
      if (_userEmail != null) {
        await _storageService.saveUserData(email: _userEmail!, name: _userName);
      }
      notifyListeners();
    } catch (_) {
      final saved = await _storageService.getUserData();
      _userName = saved['name'] ?? _userName;
      _userEmail = saved['email'] ?? _userEmail;
      notifyListeners();
    }
  }

  Future<void> loginOffline([String name = 'مستخدم محلي', String email = 'local@taskflow.offline']) async {
    _token = 'offline_token';
    _userName = name;
    _userEmail = email;
    _apiService.setToken(_token);
    await _storageService.saveToken(_token!);
    await _storageService.saveUserData(email: email, name: name);
    await _dbHelper.insertUser(name, email, 'local_offline');
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      _token = response['access_token'] as String?;
      if (_token != null) {
        _userEmail = email;
        await _storageService.saveToken(_token!);
        await fetchCurrentUser();
        return true;
      }
      return false;
    } catch (e) {
      final errStr = e.toString().toLowerCase();
      if (errStr.contains('connection') ||
          errStr.contains('socket') ||
          errStr.contains('host') ||
          errStr.contains('تعذر الاتصال') ||
          errStr.contains('مهلة الاتصال') ||
          errStr.contains('خطأ في الاتصال') ||
          errStr.contains('الوضع المحلي')) {
        final saved = await _storageService.getUserData();
        final effectiveName = (_userName != null && _userName!.isNotEmpty)
            ? _userName!
            : (saved['name'] ?? email.split('@').first);
        await loginOffline(effectiveName, email);
        return true;
      }
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.register(
        name: name,
        email: email,
        password: password,
      );

      _userName = name;
      _userEmail = email;
      await _storageService.saveUserData(email: email, name: name);
      await _dbHelper.insertUser(name, email, password);
      return true;
    } catch (e) {
      final errStr = e.toString().toLowerCase();
      if (errStr.contains('connection') ||
          errStr.contains('socket') ||
          errStr.contains('host') ||
          errStr.contains('تعذر الاتصال') ||
          errStr.contains('مهلة الاتصال') ||
          errStr.contains('خطأ في الاتصال')) {
        _userName = name;
        _userEmail = email;
        await _storageService.saveUserData(email: email, name: name);
        await loginOffline(name, email);
        return true;
      }
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    _userName = null;
    _apiService.clearToken();
    await _storageService.clearAll();
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
