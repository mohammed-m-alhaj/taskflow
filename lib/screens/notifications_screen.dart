import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';
import '../providers/reminder_provider.dart';
import '../providers/settings_provider.dart';
import 'task_detail_screen.dart';
import '../widgets/app_badge.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReminderProvider>().fetchAllReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final reminderProvider = context.watch<ReminderProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final now = DateTime.now();

    final overdueTasks = taskProvider.tasks.where((t) {
      if (t.dueDate == null || t.isCompleted) return false;
      return t.dueDate!.isBefore(now);
    }).toList();

    final todayTasks = taskProvider.tasks.where((t) {
      if (t.dueDate == null || t.isCompleted) return false;
      return t.dueDate!.year == now.year &&
          t.dueDate!.month == now.month &&
          t.dueDate!.day == now.day;
    }).toList();

    final upcomingTasks = taskProvider.tasks.where((t) {
      if (t.dueDate == null || t.isCompleted) return false;
      return t.dueDate!.isAfter(now) &&
          (t.dueDate!.day != now.day || t.dueDate!.month != now.month);
    }).toList();

    final reminders = reminderProvider.reminders;
    final totalCount =
        overdueTasks.length + todayTasks.length + upcomingTasks.length + reminders.length;

    final disabledBanner = !settingsProvider.notificationsEnabled
        ? Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              border: Border.all(color: Colors.amber.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_off, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التنبيهات معطلة حالياً',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.brown,
                        ),
                      ),
                      Text(
                        'يمكنك تفعيل التنبيهات لتلقي إشعارات المهام والتذكيرات',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    settingsProvider.toggleNotifications(true);
                  },
                  child: const Text('تفعيل'),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: const Text('التنبيهات والإشعارات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'تحديث التنبيهات',
            onPressed: () {
              reminderProvider.fetchAllReminders();
              taskProvider.fetchTasks();
            },
          ),
        ],
      ),
      body: totalCount == 0
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  disabledBanner,
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'لا توجد إشعارات أو تذكيرات حالياً',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'ستظهر هنا التذكيرات المحفوظة ومواعيد المهام',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                disabledBanner,
                if (reminders.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'تذكيرات مجدولة (Reminders) 🔔',
                    Colors.purple,
                    reminders.length,
                  ),
                  ...reminders.map((r) {
                    final linkedTask = taskProvider.getTaskById(r.taskId);
                    final formattedTime =
                        DateFormat('yyyy/MM/dd - hh:mm a').format(r.reminderTime);
                    return AppActionTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple.withAlpha(30),
                        child: const Icon(Icons.alarm, color: Colors.purple, size: 20),
                      ),
                      title: Text(
                        linkedTask?.title ?? 'المهمة #${r.taskId}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text('موعد التذكير: $formattedTime'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final success =
                              await reminderProvider.deleteReminder(r.id);
                          if (success && mounted) {
                            messenger.showSnackBar(
                              const SnackBar(content: Text('تم حذف التذكير')),
                            );
                          }
                        },
                      ),
                      onTap: linkedTask != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TaskDetailScreen(task: linkedTask),
                                ),
                              );
                            }
                          : null,
                    );
                  }),
                  const SizedBox(height: 16),
                ],
                if (overdueTasks.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'مهام متأخرة ⚠️',
                    Colors.red,
                    overdueTasks.length,
                  ),
                  ...overdueTasks.map((t) => _buildNotificationCard(
                        context,
                        title: t.title,
                        subtitle: 'كان موعد الاستحقاق: ${DateFormat('yyyy/MM/dd').format(t.dueDate!)}',
                        icon: Icons.warning_amber_rounded,
                        color: Colors.red,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailScreen(task: t),
                            ),
                          );
                        },
                      )),
                  const SizedBox(height: 16),
                ],
                if (todayTasks.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'مستحقة اليوم 🔔',
                    Colors.orange,
                    todayTasks.length,
                  ),
                  ...todayTasks.map((t) => _buildNotificationCard(
                        context,
                        title: t.title,
                        subtitle: 'مستحقة اليوم: ${DateFormat('HH:mm').format(t.dueDate!)}',
                        icon: Icons.alarm,
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailScreen(task: t),
                            ),
                          );
                        },
                      )),
                  const SizedBox(height: 16),
                ],
                if (upcomingTasks.isNotEmpty) ...[
                  _buildSectionHeader(
                    context,
                    'مهام قادمة 📅',
                    Colors.blue,
                    upcomingTasks.length,
                  ),
                  ...upcomingTasks.map((t) => _buildNotificationCard(
                        context,
                        title: t.title,
                        subtitle: 'موعد الاستحقاق: ${DateFormat('yyyy/MM/dd').format(t.dueDate!)}',
                        icon: Icons.calendar_today,
                        color: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailScreen(task: t),
                            ),
                          );
                        },
                      )),
                ],
              ],
            ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    Color color,
    int count,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AppActionTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color.withAlpha(30),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_left, size: 18),
    );
  }
}
