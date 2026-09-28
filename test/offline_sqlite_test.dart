import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/providers/auth_provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/providers/settings_provider.dart';
import 'package:to_do_list/providers/reminder_provider.dart';
import 'package:to_do_list/providers/category_provider.dart';

void main() {
  test('Complete Offline SQLite Local Database & CRUD Verification', () async {
    final authProvider = AuthProvider();
    final taskProvider = TaskProvider();
    final settingsProvider = SettingsProvider();
    final reminderProvider = ReminderProvider();
    final categoryProvider = CategoryProvider();

    authProvider.loginOffline();
    expect(authProvider.isAuthenticated, isTrue);
    expect(authProvider.userName, 'مستخدم محلي');

    final catSuccess = await categoryProvider.addCategory('مشروع التخرج بدون نت');
    expect(catSuccess, isTrue);
    expect(categoryProvider.categories.isNotEmpty, isTrue);
    final catId = categoryProvider.categories.first.id;

    final addSuccess = await taskProvider.addTask(
      title: 'مهمة محلية داخل هاتف الأندرويد',
      description: 'مخزنة بالكامل في قاعدة بيانات SQLite المحلية بدون إنترنت',
      priority: 'high',
      status: 'pending',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      categoryId: catId,
    );
    expect(addSuccess, isTrue);
    expect(taskProvider.tasks.isNotEmpty, isTrue);
    final taskId = taskProvider.tasks.first.id;

    final subtask = await taskProvider.addSubtask(taskId, 'فحص تخزين SQLite محليا');
    expect(subtask, isNotNull);
    final subtaskId = subtask!.id;

    final toggleSuccess = await taskProvider.toggleSubtask(subtaskId, true);
    expect(toggleSuccess, isTrue);

    final subtasks = await taskProvider.fetchSubtasks(taskId);
    expect(subtasks.isNotEmpty, isTrue);
    expect(subtasks.first.isCompleted, isTrue);

    final reminder = await reminderProvider.createReminder(
      taskId,
      DateTime.now().add(const Duration(hours: 5)),
    );
    expect(reminder, isNotNull);
    final reminderId = reminder!.id;

    await reminderProvider.fetchAllReminders();
    expect(reminderProvider.reminders.any((r) => r.id == reminderId), isTrue);

    final delReminderSuccess = await reminderProvider.deleteReminder(reminderId);
    expect(delReminderSuccess, isTrue);

    final updateSuccess = await taskProvider.updateTask(
      taskId,
      {
        'title': 'مهمة محلية محدثة بنجاح',
        'priority': 'medium',
        'is_completed': true,
      },
    );
    expect(updateSuccess, isTrue);

    await settingsProvider.setLanguage('ar');
    await settingsProvider.setThemeMode(ThemeMode.dark);
    expect(settingsProvider.language, 'ar');
    expect(settingsProvider.themeMode, ThemeMode.dark);

    final delSubSuccess = await taskProvider.deleteSubtask(subtaskId);
    expect(delSubSuccess, isTrue);

    final deleteTaskSuccess = await taskProvider.deleteTask(taskId);
    expect(deleteTaskSuccess, isTrue);

    final deleteCatSuccess = await categoryProvider.deleteCategory(catId);
    expect(deleteCatSuccess, isTrue);
  });
}
