import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../models/subtask.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

class TaskProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get totalTasks => _tasks.length;

  int get completedTasks =>
      _tasks.where((task) => task.isCompleted).length;

  int get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).length;

  int get overdueTasks {
    final now = DateTime.now();

    return _tasks.where((task) {
      if (task.dueDate == null || task.isCompleted) {
        return false;
      }

      return task.dueDate!.isBefore(now);
    }).length;
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final localData = await _dbHelper.getTasks();
      _tasks = localData.map((item) => Task.fromJson(item)).toList();
      _isLoading = false;
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.getTasks().then((data) async {
          _tasks = data.map((item) => Task.fromJson(item)).toList();
          for (final t in _tasks) {
            await _dbHelper.insertTask({
              'id': t.id,
              'user_id': t.userId,
              'category_id': t.categoryId,
              'title': t.title,
              'description': t.description,
              'priority': t.priority,
              'status': t.status,
              'due_date': t.dueDate?.toIso8601String(),
              'is_completed': t.isCompleted ? 1 : 0,
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

  Future<Task?> createTaskAndReturn({
    required String title,
    String? description,
    String priority = 'medium',
    String status = 'pending',
    DateTime? dueDate,
    int? categoryId,
  }) async {
    _errorMessage = null;

    try {
      final localRow = {
        'user_id': 1,
        'title': title,
        'description': description,
        'priority': priority,
        'status': status,
        'due_date': dueDate?.toIso8601String(),
        'category_id': categoryId,
        'is_completed': 0,
      };

      final localId = await _dbHelper.insertTask(localRow);

      final task = Task(
        id: localId,
        userId: 1,
        title: title,
        description: description,
        priority: priority,
        status: status,
        dueDate: dueDate,
        categoryId: categoryId,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      _tasks.insert(0, task);
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService
            .createTask(
          title: title,
          description: description,
          priority: priority,
          status: status,
          dueDate: dueDate,
          categoryId: categoryId,
        )
            .then((data) async {
          final serverTask = Task.fromJson(data);
          await _dbHelper.updateTask(localId, {'id': serverTask.id});
        }).catchError((_) {});
      }

      return task;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return null;
    }
  }

  Future<bool> addTask({
    required String title,
    String? description,
    String priority = 'medium',
    String status = 'pending',
    DateTime? dueDate,
    int? categoryId,
  }) async {
    final task = await createTaskAndReturn(
      title: title,
      description: description,
      priority: priority,
      status: status,
      dueDate: dueDate,
      categoryId: categoryId,
    );

    return task != null;
  }

  Future<bool> updateTask(
    int taskId,
    Map<String, dynamic> updateFields,
  ) async {
    _errorMessage = null;

    try {
      await _dbHelper.updateTask(taskId, updateFields);

      final index = _tasks.indexWhere(
        (task) => task.id == taskId,
      );

      if (index != -1) {
        final old = _tasks[index];
        _tasks[index] = old.copyWith(
          title: updateFields['title'] as String?,
          description: updateFields['description'] as String?,
          priority: updateFields['priority'] as String?,
          status: updateFields['status'] as String?,
          dueDate: updateFields.containsKey('due_date')
              ? (updateFields['due_date'] != null
                  ? DateTime.parse(updateFields['due_date'])
                  : null)
              : old.dueDate,
          categoryId: updateFields['category_id'] as int?,
          isCompleted: updateFields['is_completed'] as bool?,
        );
        notifyListeners();
      }

      if (_apiService.hasToken) {
        _apiService.updateTask(taskId, updateFields).then((data) {
          final updatedTask = Task.fromJson(data);
          final idx = _tasks.indexWhere((t) => t.id == taskId);
          if (idx != -1) {
            _tasks[idx] = updatedTask;
            notifyListeners();
          }
        }).catchError((_) {});
      }

      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTask(int taskId) async {
    _errorMessage = null;

    try {
      await _dbHelper.deleteTask(taskId);

      _tasks.removeWhere(
        (task) => task.id == taskId,
      );

      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.deleteTask(taskId).catchError((_) {});
      }

      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<List<Subtask>> fetchSubtasks(int taskId) async {
    final localData = await _dbHelper.getSubtasks(taskId);
    final list = localData.map((s) => Subtask.fromJson(s)).toList();

    if (_apiService.hasToken) {
      _apiService.getSubtasks(taskId).then((data) async {
        if (data.isNotEmpty) {
          for (final s in data) {
            await _dbHelper.insertSubtask({
              'id': s['id'],
              'task_id': s['task_id'],
              'title': s['title'],
              'is_completed': s['is_completed'] == true ? 1 : 0,
            });
          }
          notifyListeners();
        }
      }).catchError((_) {});
    }
    return list;
  }

  Future<Subtask?> addSubtask(int taskId, String title) async {
    try {
      final id = await _dbHelper.insertSubtask({'task_id': taskId, 'title': title, 'is_completed': 0});
      final subtask = Subtask(id: id, taskId: taskId, title: title, isCompleted: false);
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.createSubtask(taskId, title).then((data) async {
          final serverSub = Subtask.fromJson(data);
          await _dbHelper.updateSubtask(id, {'id': serverSub.id});
        }).catchError((_) {});
      }

      return subtask;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return null;
    }
  }

  Future<bool> toggleSubtask(int subtaskId, bool isCompleted) async {
    try {
      await _dbHelper.updateSubtask(subtaskId, {'is_completed': isCompleted ? 1 : 0});
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.updateSubtask(subtaskId, {'is_completed': isCompleted}).then((_) {}, onError: (_) {});
      }

      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSubtask(int subtaskId) async {
    try {
      await _dbHelper.deleteSubtask(subtaskId);
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.deleteSubtask(subtaskId).catchError((_) {});
      }

      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Task? getTaskById(int taskId) {
    try {
      return _tasks.firstWhere(
        (task) => task.id == taskId,
      );
    } catch (_) {
      return null;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
