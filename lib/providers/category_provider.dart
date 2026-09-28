import 'package:flutter/foundation.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

class CategoryProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<TaskCategory> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TaskCategory> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final localData = await _dbHelper.getCategories();
      _categories = localData.map((item) => TaskCategory.fromJson(item)).toList();
      _isLoading = false;
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.getCategories().then((data) async {
          _categories = data.map((item) => TaskCategory.fromJson(item)).toList();
          for (final c in _categories) {
            await _dbHelper.insertCategory({
              'id': c.id,
              'user_id': c.userId,
              'name': c.name,
              'created_at': c.createdAt?.toIso8601String(),
            });
          }
          notifyListeners();
        }).catchError((_) {});
      }
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addCategory(String name) async {
    if (name.trim().isEmpty) return false;

    _errorMessage = null;
    try {
      final localId = await _dbHelper.insertCategory({
        'user_id': 1,
        'name': name.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });

      final cat = TaskCategory(
        id: localId,
        userId: 1,
        name: name.trim(),
        createdAt: DateTime.now(),
      );

      _categories.add(cat);
      _categories.sort((a, b) => a.name.compareTo(b.name));
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.createCategory(name.trim()).then((data) async {
          final remoteCat = TaskCategory.fromJson(data);
          await _dbHelper.updateCategory(localId, {'id': remoteCat.id});
          _categories.removeWhere((c) => c.id == localId);
          _categories.add(remoteCat);
          _categories.sort((a, b) => a.name.compareTo(b.name));
          notifyListeners();
        }).catchError((_) {});
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCategory(int categoryId) async {
    _errorMessage = null;
    try {
      await _dbHelper.deleteCategory(categoryId);
      _categories.removeWhere((cat) => cat.id == categoryId);
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.deleteCategory(categoryId).catchError((_) {});
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  TaskCategory? getCategoryById(int? categoryId) {
    if (categoryId == null) return null;
    try {
      return _categories.firstWhere((cat) => cat.id == categoryId);
    } catch (_) {
      return null;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
