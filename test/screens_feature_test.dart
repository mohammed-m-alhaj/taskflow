import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/auth_provider.dart';
import 'package:to_do_list/providers/settings_provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/providers/reminder_provider.dart';
import 'package:to_do_list/screens/ai_assistant_screen.dart';
import 'package:to_do_list/screens/calendar_screen.dart';
import 'package:to_do_list/screens/notifications_screen.dart';
import 'package:to_do_list/screens/profile_screen.dart';
import 'package:to_do_list/screens/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen theme and toggles test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ],
        child: const MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    expect(find.text('الإعدادات'), findsOneWidget);
    expect(find.text('المظهر وتنسيق الألوان'), findsOneWidget);
    expect(find.text('تفعيل الإشعارات'), findsOneWidget);
    expect(find.text('ملخص يومي'), findsOneWidget);
  });

  testWidgets('ProfileScreen stats and actions test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: const MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );

    expect(find.text('الملف الشخصي'), findsOneWidget);
    expect(find.text('إحصائيات الإنجاز'), findsOneWidget);
    expect(find.text('تسجيل الخروج'), findsOneWidget);
  });

  testWidgets('CalendarScreen month and days test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: const MaterialApp(
          home: CalendarScreen(),
        ),
      ),
    );

    expect(find.text('التقويم ومواعيد المهام'), findsOneWidget);
    expect(find.byIcon(Icons.today), findsOneWidget);
  });

  testWidgets('NotificationsScreen empty state test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ],
        child: const MaterialApp(
          home: NotificationsScreen(),
        ),
      ),
    );

    expect(find.text('التنبيهات والإشعارات'), findsOneWidget);
    expect(find.text('لا توجد إشعارات أو تذكيرات حالياً'), findsOneWidget);
  });

  testWidgets('NotificationsScreen with overdue and today tasks test', (tester) async {
    final taskProvider = TaskProvider();
    final now = DateTime.now();

    final testTask = Task(
      id: 101,
      userId: 1,
      title: 'مهمة متأخرة للتنبيه',
      priority: 'high',
      status: 'pending',
      dueDate: now.subtract(const Duration(days: 1)),
      isCompleted: false,
    );

    taskProvider.tasks.add(testTask);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider.value(value: taskProvider),
          ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ],
        child: const MaterialApp(
          home: NotificationsScreen(),
        ),
      ),
    );

    expect(find.text('التنبيهات والإشعارات'), findsOneWidget);
    expect(find.text('مهام متأخرة ⚠️'), findsOneWidget);
    expect(find.text('مهمة متأخرة للتنبيه'), findsOneWidget);
  });

  testWidgets('AiAssistantScreen quick suggestions and input test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: const MaterialApp(
          home: AiAssistantScreen(),
        ),
      ),
    );

    expect(find.text('مساعد الذكاء الاصطناعي'), findsOneWidget);
    expect(find.text('تخطيط ذكي للمهام ⚡'), findsOneWidget);
    expect(find.text('مذاكرة لاختبار مادة قواعد البيانات'), findsOneWidget);

    await tester.tap(find.text('مذاكرة لاختبار مادة قواعد البيانات'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));

    expect(find.text('الخطة المقترحة'), findsOneWidget);
    expect(find.text('إضافة الخطة إلى مهامي الآن'), findsOneWidget);
  });
}
