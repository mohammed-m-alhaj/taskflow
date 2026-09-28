import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;
  String? _token;
  bool _isServerReachable = true;
  DateTime? _lastFailureTime;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: defaultBaseUrl,
        connectTimeout: const Duration(milliseconds: 1200),
        receiveTimeout: const Duration(milliseconds: 1500),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (isOfflineMode) {
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                error: 'الوضع المحلي نشط - لا توجد اتصالات شبكية',
              ),
            );
          }

          if (_token != null && _token!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            _isServerReachable = false;
            _lastFailureTime = DateTime.now();
          }
          return handler.next(error);
        },
      ),
    );
  }

  static String get defaultBaseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    }
    return 'http://127.0.0.1:8000';
  }

  void setToken(String? token) {
    _token = token;
    resetServerAvailability();
  }

  void clearToken() {
    _token = null;
  }

  String? get token => _token;
  bool get isOfflineMode => _token == null || _token == 'offline_token';

  bool get isServerAvailable {
    if (isOfflineMode) return false;
    if (!_isServerReachable) {
      if (_lastFailureTime != null &&
          DateTime.now().difference(_lastFailureTime!) > const Duration(seconds: 30)) {
        _isServerReachable = true;
        return true;
      }
      return false;
    }
    return true;
  }

  void resetServerAvailability() {
    _isServerReachable = true;
    _lastFailureTime = null;
  }

  bool get hasToken =>
      _token != null &&
      _token!.isNotEmpty &&
      _token != 'offline_token' &&
      isServerAvailable;

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final data = Map<String, dynamic>.from(response.data);
      if (data.containsKey('access_token')) {
        setToken(data['access_token'] as String);
      }
      return data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await _dio.get('/tasks');
      final list = response.data as List<dynamic>;
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getTask(int taskId) async {
    try {
      final response = await _dio.get('/tasks/$taskId');
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> createTask({
    required String title,
    String? description,
    String priority = 'medium',
    String status = 'pending',
    DateTime? dueDate,
    int? categoryId,
  }) async {
    try {
      final response = await _dio.post(
        '/tasks',
        data: {
          'title': title,
          'description': description,
          'priority': priority,
          'status': status,
          'due_date': dueDate?.toIso8601String(),
          'category_id': categoryId,
        },
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateTask(
    int taskId,
    Map<String, dynamic> updateFields,
  ) async {
    try {
      final response = await _dio.put(
        '/tasks/$taskId',
        data: updateFields,
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await _dio.delete('/tasks/$taskId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getSubtasks(int taskId) async {
    try {
      final response = await _dio.get('/tasks/$taskId/subtasks');
      final list = response.data as List<dynamic>;
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> createSubtask(int taskId, String title) async {
    try {
      final response = await _dio.post(
        '/tasks/$taskId/subtasks',
        data: {'title': title, 'is_completed': false},
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateSubtask(
    int subtaskId,
    Map<String, dynamic> fields,
  ) async {
    try {
      final response = await _dio.put(
        '/subtasks/$subtaskId',
        data: fields,
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteSubtask(int subtaskId) async {
    try {
      await _dio.delete('/subtasks/$subtaskId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getUserSettings() async {
    try {
      final response = await _dio.get('/users/settings');
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateUserSettings(
    Map<String, dynamic> fields,
  ) async {
    try {
      final response = await _dio.put(
        '/users/settings',
        data: fields,
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllReminders() async {
    try {
      final response = await _dio.get('/reminders');
      final list = response.data as List<dynamic>;
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getReminders(int taskId) async {
    try {
      final response = await _dio.get('/tasks/$taskId/reminders');
      final list = response.data as List<dynamic>;
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> createReminder(
    int taskId,
    DateTime reminderTime,
  ) async {
    try {
      final response = await _dio.post(
        '/tasks/$taskId/reminders',
        data: {'reminder_time': reminderTime.toIso8601String(), 'is_enabled': true},
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteReminder(int reminderId) async {
    try {
      await _dio.delete('/reminders/$reminderId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final response = await _dio.get('/categories');
      final list = response.data as List<dynamic>;
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> createCategory(String name) async {
    try {
      final response = await _dio.post(
        '/categories',
        data: {'name': name},
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    try {
      await _dio.delete('/categories/$categoryId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    String message = 'حدث خطأ في الاتصال بالخادم';

    if (error.response != null && error.response?.data != null) {
      final data = error.response!.data;
      if (data is Map && data.containsKey('detail')) {
        final detail = data['detail'].toString();
        if (detail == 'Invalid token' || detail == 'Not authenticated') {
          message = 'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مجدداً';
        } else {
          message = detail;
        }
      } else if (data is String) {
        message = data;
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      message = 'انتهت مهلة الاتصال بالخادم، يرجى المحاولة لاحقاً';
    } else if (error.type == DioExceptionType.connectionError) {
      message = 'تعذر الاتصال بالخادم. تأكد من تشغيل الـ Backend على المنفذ 8000';
    }

    return Exception(message);
  }
}
