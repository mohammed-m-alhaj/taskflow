import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

class ReminderProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Reminder> _reminders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Reminder> get reminders => _reminders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAllReminders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final localData = await _dbHelper.getReminders();
      _reminders = localData.map((json) => Reminder.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.getAllReminders().then((data) async {
          _reminders = data.map((json) => Reminder.fromJson(json)).toList();
          for (final r in _reminders) {
            await _dbHelper.insertReminder({
              'id': r.id,
              'task_id': r.taskId,
              'reminder_time': r.reminderTime.toIso8601String(),
              'reminder_type': 'notification',
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

  Future<List<Reminder>> fetchRemindersForTask(int taskId) async {
    final localData = await _dbHelper.getReminders(taskId: taskId);
    final list = localData.map((json) => Reminder.fromJson(json)).toList();

    if (_apiService.hasToken) {
      _apiService.getReminders(taskId).then((data) async {
        if (data.isNotEmpty) {
          for (final r in data) {
            await _dbHelper.insertReminder({
              'id': r['id'],
              'task_id': r['task_id'],
              'reminder_time': r['reminder_time'],
              'reminder_type': 'notification',
            });
          }
          notifyListeners();
        }
      }).catchError((_) {});
    }
    return list;
  }

  Future<Reminder?> createReminder(int taskId, DateTime reminderTime) async {
    _errorMessage = null;
    try {
      final localId = await _dbHelper.insertReminder({
        'task_id': taskId,
        'reminder_time': reminderTime.toIso8601String(),
        'reminder_type': 'notification',
      });

      final reminder = Reminder(
        id: localId,
        taskId: taskId,
        reminderTime: reminderTime,
      );

      _reminders.add(reminder);
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.createReminder(taskId, reminderTime).then((data) async {
          final serverRem = Reminder.fromJson(data);
          await _dbHelper.updateReminder(localId, {'id': serverRem.id});
        }).catchError((_) {});
      }

      return reminder;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return null;
    }
  }

  Future<bool> deleteReminder(int reminderId) async {
    _errorMessage = null;
    try {
      await _dbHelper.deleteReminder(reminderId);
      _reminders.removeWhere((r) => r.id == reminderId);
      notifyListeners();

      if (_apiService.hasToken) {
        _apiService.deleteReminder(reminderId).catchError((_) {});
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
