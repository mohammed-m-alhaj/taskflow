import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/providers/auth_provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/providers/settings_provider.dart';
import 'package:to_do_list/providers/reminder_provider.dart';
import 'package:to_do_list/providers/category_provider.dart';

void main() {
  test('Complete Academic Architecture & CRUD Verification', () async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final testEmail = 'doctor_eval_$timestamp@academic.edu';
    final testPassword = 'SecurePassword123';
    final testName = 'Academic Student';

    final authProvider = AuthProvider();
    final taskProvider = TaskProvider();
    final settingsProvider = SettingsProvider();
    final reminderProvider = ReminderProvider();
    final categoryProvider = CategoryProvider();

    final regSuccess =
        await authProvider.register(testName, testEmail, testPassword);
    expect(regSuccess, isTrue);

    final loginSuccess = await authProvider.login(testEmail, testPassword);
    expect(loginSuccess, isTrue);
    expect(authProvider.token, isNotNull);

    await authProvider.fetchCurrentUser();
    expect(authProvider.userEmail, testEmail);
    expect(authProvider.userName, testName);

    await taskProvider.fetchTasks();
    expect(taskProvider.tasks.length, 0);

    final catSuccess = await categoryProvider.addCategory('مشاريع التخرج');
    expect(catSuccess, isTrue);
    expect(categoryProvider.categories.length, 1);
    final catId = categoryProvider.categories.first.id;

    final addSuccess = await taskProvider.addTask(
      title: 'مهمة التقييم الأكاديمي الشامل',
      description: 'اختبار الربط المتكامل بين فلاتر وباك إند وقاعدة البيانات',
      priority: 'high',
      status: 'pending',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      categoryId: catId,
    );
    expect(addSuccess, isTrue);
    expect(taskProvider.tasks.length, 1);
    expect(taskProvider.tasks.first.categoryId, catId);
    final taskId = taskProvider.tasks.first.id;

    final subtask = await taskProvider.addSubtask(
        taskId, 'التحقق من صحة الربط مع PostgreSQL');
    expect(subtask, isNotNull);
    final subtaskId = subtask!.id;

    final toggleSubSuccess =
        await taskProvider.toggleSubtask(subtaskId, true);
    expect(toggleSubSuccess, isTrue);

    final subtasksList = await taskProvider.fetchSubtasks(taskId);
    expect(subtasksList.length, 1);
    expect(subtasksList.first.isCompleted, isTrue);

    final reminderTime = DateTime.now().add(const Duration(days: 1));
    final reminder =
        await reminderProvider.createReminder(taskId, reminderTime);
    expect(reminder, isNotNull);
    final reminderId = reminder!.id;

    await reminderProvider.fetchAllReminders();
    expect(reminderProvider.reminders.any((r) => r.id == reminderId), isTrue);

    final delReminderSuccess =
        await reminderProvider.deleteReminder(reminderId);
    expect(delReminderSuccess, isTrue);

    final delSubSuccess = await taskProvider.deleteSubtask(subtaskId);
    expect(delSubSuccess, isTrue);

    await settingsProvider.syncWithBackend();
    await settingsProvider.toggleNotifications(true);

    final updateSuccess = await taskProvider.updateTask(
      taskId,
      {
        'title': 'مهمة التقييم الأكاديمي (محدثة)',
        'priority': 'medium',
        'is_completed': true,
      },
    );
    expect(updateSuccess, isTrue);

    final deleteSuccess = await taskProvider.deleteTask(taskId);
    expect(deleteSuccess, isTrue);

    final delCatSuccess = await categoryProvider.deleteCategory(catId);
    expect(delCatSuccess, isTrue);

    await authProvider.logout();
    expect(authProvider.isAuthenticated, isFalse);
  });
}
