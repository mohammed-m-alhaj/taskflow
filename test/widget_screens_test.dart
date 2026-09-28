import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/auth_provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/providers/reminder_provider.dart';
import 'package:to_do_list/screens/login_screen.dart';
import 'package:to_do_list/screens/task_detail_screen.dart';

void main() {
  testWidgets('LoginScreen smoke test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    expect(find.text('تاسك فلو'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsWidgets);
    expect(find.text('البريد الإلكتروني'), findsOneWidget);
    expect(find.text('كلمة المرور'), findsOneWidget);
  });

  testWidgets('TaskDetailScreen render and edit toggle test', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final sampleTask = Task(
      id: 99,
      userId: 5,
      title: 'مهمة تجربة الواجهات',
      description: 'وصف تجريبي للواجهة',
      priority: 'high',
      status: 'pending',
      dueDate: DateTime(2026, 9, 15, 10, 30),
      isCompleted: false,
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ],
        child: MaterialApp(
          home: TaskDetailScreen(task: sampleTask),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('تفاصيل المهمة'), findsOneWidget);
    expect(find.text('مهمة تجربة الواجهات'), findsOneWidget);
    expect(find.text('وصف تجريبي للواجهة'), findsOneWidget);
    expect(find.text('غير مكتملة'), findsOneWidget);
    expect(find.text('عالية 🔴'), findsOneWidget);

    await tester.ensureVisible(find.text('تعديل المهمة'));
    await tester.tap(find.text('تعديل المهمة'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('حفظ التعديلات'), findsOneWidget);
    expect(find.text('إلغاء'), findsOneWidget);

    await tester.ensureVisible(find.text('إلغاء'));
    await tester.tap(find.text('إلغاء'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('تعديل المهمة'), findsOneWidget);
  });
}
