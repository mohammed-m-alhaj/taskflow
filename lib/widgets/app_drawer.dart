import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/calendar_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/ai_assistant_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, this.currentRoute = 'home'});

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await context.read<AuthProvider>().logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final auth = context.watch<AuthProvider>();
    final userName = auth.userName ?? 'مستخدم تاسك فلو';
    final userEmail = auth.userEmail ?? 'user@example.com';
    final initial = userName.trim().isNotEmpty ? userName.trim()[0].toUpperCase() : 'U';

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 24, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        theme.colorScheme.primary.withAlpha(90),
                        theme.colorScheme.surfaceContainerHighest,
                      ]
                    : [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withAlpha(210),
                      ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(30),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          initial,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withAlpha(200),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(radius: 4, backgroundColor: Color(0xFF4ADE80)),
                      SizedBox(width: 6),
                      Text(
                        'جلسة نشطة • متصل',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: [
                _drawerItem(
                  context: context,
                  icon: Icons.home_rounded,
                  iconColor: const Color(0xFF2563EB),
                  title: 'الرئيسية',
                  isSelected: currentRoute == 'home',
                  onTap: () => Navigator.pop(context),
                ),
                _drawerItem(
                  context: context,
                  icon: Icons.calendar_month_rounded,
                  iconColor: const Color(0xFF10B981),
                  title: 'التقويم والمواعيد',
                  isSelected: currentRoute == 'calendar',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'calendar') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CalendarScreen()),
                      );
                    }
                  },
                ),
                _drawerItem(
                  context: context,
                  icon: Icons.category_rounded,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'إدارة التصنيفات',
                  isSelected: currentRoute == 'categories',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'categories') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                      );
                    }
                  },
                ),
                _drawerItem(
                  context: context,
                  icon: Icons.auto_awesome_rounded,
                  iconColor: const Color(0xFF8B5CF6),
                  title: 'مساعد الذكاء الاصطناعي',
                  isSelected: currentRoute == 'ai',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'ai') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AiAssistantScreen()),
                      );
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Divider(),
                ),
                _drawerItem(
                  context: context,
                  icon: Icons.person_outline_rounded,
                  iconColor: const Color(0xFF0284C7),
                  title: 'الملف الشخصي',
                  isSelected: currentRoute == 'profile',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'profile') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                      );
                    }
                  },
                ),
                _drawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  iconColor: const Color(0xFF64748B),
                  title: 'الإعدادات',
                  isSelected: currentRoute == 'settings',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'settings') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
            ),
            child: ListTile(
              dense: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              tileColor: Colors.red.withAlpha(15),
              leading: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
              ),
              title: const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmLogout(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        dense: true,
        selected: isSelected,
        selectedTileColor: theme.colorScheme.primaryContainer.withAlpha(120),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withAlpha(35)
                : iconColor.withAlpha(22),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isSelected ? theme.colorScheme.primary : iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected ? theme.colorScheme.primary : null,
          ),
        ),
        trailing: isSelected
            ? CircleAvatar(radius: 4, backgroundColor: theme.colorScheme.primary)
            : const Icon(Icons.chevron_left_rounded, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
