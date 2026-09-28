import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/providers/auth_provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/providers/settings_provider.dart';

void main() {
  testWidgets('TaskFlow app launch and splash test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ],
        child: const TaskFlowApp(),
      ),
    );

    expect(find.text('تاسك فلو'), findsOneWidget);
    expect(find.text('نظّم مهامك وحقق أهدافك'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('تسجيل الدخول'), findsWidgets);
  });
}