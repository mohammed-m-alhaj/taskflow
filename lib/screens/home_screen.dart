import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';
import '../providers/category_provider.dart';
import 'add_task_screen.dart';
import 'ai_assistant_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'task_detail_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_shimmer.dart';
import '../widgets/app_badge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<TaskProvider>().fetchTasks();
        context.read<CategoryProvider>().fetchCategories();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Task> _filterTasks(List<Task> tasks) {
    final query = _searchController.text.trim().toLowerCase();
    final now = DateTime.now();

    return tasks.where((task) {
      if (query.isNotEmpty) {
        final titleMatches = task.title.toLowerCase().contains(query);
        final descMatches =
            task.description?.toLowerCase().contains(query) ?? false;
        if (!titleMatches && !descMatches) return false;
      }

      switch (_selectedFilter) {
        case 'pending':
          return !task.isCompleted;
        case 'completed':
          return task.isCompleted;
        case 'high':
          return task.priority == 'high';
        case 'overdue':
          return task.dueDate != null &&
              !task.isCompleted &&
              task.dueDate!.isBefore(now);
        case 'all':
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (scaffoldContext) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            tooltip: 'القائمة الرئيسية',
            onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
          ),
        ),
        title: const Text(
          'تاسك فلو',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'مساعد الذكاء الاصطناعي',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AiAssistantScreen(),
                ),
              );
            },
            icon: const Icon(Icons.auto_awesome),
          ),
          IconButton(
            tooltip: 'التنبيهات',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            tooltip: 'الملف الشخصي',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: 'home'),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading && taskProvider.tasks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: ShimmerTaskList(count: 5),
            );
          }

          final filteredTasks = _filterTasks(taskProvider.tasks);
          final total = taskProvider.totalTasks;
          final completed = taskProvider.completedTasks;
          final completionRate = total > 0 ? completed / total : 0.0;

          return RefreshIndicator(
            onRefresh: () async {
              await taskProvider.fetchTasks();
              if (context.mounted) {
                await context.read<CategoryProvider>().fetchCategories();
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeaderCard(
                    title: 'مرحباً بك، ${authProvider.userName ?? ""} 👋',
                    subtitle: 'نظّم مهامك وأنجز أهدافك اليوم بكل سهولة',
                    bottom: total > 0
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'نسبة إنجاز المهام',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Text(
                                    '$completed من $total (${(completionRate * 100).toInt()}%)',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: completionRate,
                                  minHeight: 8,
                                  backgroundColor: isDark
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    completionRate == 1.0
                                        ? Colors.green
                                        : theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'ابحث في المهام...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: isDark
                          ? theme.colorScheme.surfaceContainerHighest
                          : Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: AppStatCard(
                          title: 'إجمالي المهام',
                          value: '${taskProvider.totalTasks}',
                          icon: Icons.assignment_rounded,
                          accentColor: const Color(0xFF2563EB),
                          isSelected: _selectedFilter == 'all',
                          onTap: () => setState(() => _selectedFilter = 'all'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppStatCard(
                          title: 'مكتملة',
                          value: '${taskProvider.completedTasks}',
                          icon: Icons.check_circle_rounded,
                          accentColor: const Color(0xFF10B981),
                          isSelected: _selectedFilter == 'completed',
                          onTap: () => setState(() => _selectedFilter = 'completed'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AppStatCard(
                          title: 'قيد التنفيذ',
                          value: '${taskProvider.pendingTasks}',
                          icon: Icons.hourglass_top_rounded,
                          accentColor: const Color(0xFFF59E0B),
                          isSelected: _selectedFilter == 'pending',
                          onTap: () => setState(() => _selectedFilter = 'pending'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppStatCard(
                          title: 'متأخرة',
                          value: '${taskProvider.overdueTasks}',
                          icon: Icons.warning_amber_rounded,
                          accentColor: const Color(0xFFEF4444),
                          isSelected: _selectedFilter == 'overdue',
                          onTap: () => setState(() => _selectedFilter = 'overdue'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AppChoiceChip<String>(
                          value: 'all',
                          selectedValue: _selectedFilter,
                          label: 'الكل (${taskProvider.totalTasks})',
                          icon: Icons.all_inclusive_rounded,
                          onSelected: (val) => setState(() => _selectedFilter = val),
                        ),
                        const SizedBox(width: 8),
                        AppChoiceChip<String>(
                          value: 'pending',
                          selectedValue: _selectedFilter,
                          label: 'قيد التنفيذ (${taskProvider.pendingTasks})',
                          icon: Icons.schedule_rounded,
                          onSelected: (val) => setState(() => _selectedFilter = val),
                        ),
                        const SizedBox(width: 8),
                        AppChoiceChip<String>(
                          value: 'completed',
                          selectedValue: _selectedFilter,
                          label: 'المكتملة (${taskProvider.completedTasks})',
                          icon: Icons.done_all_rounded,
                          onSelected: (val) => setState(() => _selectedFilter = val),
                        ),
                        const SizedBox(width: 8),
                        AppChoiceChip<String>(
                          value: 'high',
                          selectedValue: _selectedFilter,
                          label: 'عالية الأولوية 🔴',
                          icon: Icons.flag_rounded,
                          onSelected: (val) => setState(() => _selectedFilter = val),
                        ),
                        const SizedBox(width: 8),
                        AppChoiceChip<String>(
                          value: 'overdue',
                          selectedValue: _selectedFilter,
                          label: 'متأخرة (${taskProvider.overdueTasks})',
                          icon: Icons.alarm_off_rounded,
                          onSelected: (val) => setState(() => _selectedFilter = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'قائمة المهام',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${filteredTasks.length} مهمة',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (taskProvider.errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.red.shade50,
                      ),
                      child: Text(
                        taskProvider.errorMessage!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  if (filteredTasks.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: isDark
                            ? theme.colorScheme.surfaceContainerHighest.withAlpha(90)
                            : Colors.grey.shade50,
                        border: Border.all(
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(25),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.task_alt_rounded,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'لا توجد نتائج مطابقة للبحث'
                                : 'لا توجد مهام في هذا التصنيف',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'جرب البحث بكلمات أخرى'
                                : 'ابدأ يومك بإضافة مهمة جديدة لإنجازها',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Consumer<CategoryProvider>(
                      builder: (context, catProvider, _) {
                        return Column(
                          children: filteredTasks.map((task) {
                            final category = task.categoryId != null
                                ? catProvider.categories.cast<dynamic>().firstWhere(
                                    (c) => c.id == task.categoryId,
                                    orElse: () => null,
                                  )
                                : null;

                            return AppTaskCard(
                              dismissibleKey: ValueKey(task.id),
                              title: task.title,
                              description: task.description,
                              priority: task.priority,
                              categoryName: category?.name,
                              dueDate: task.dueDate,
                              isCompleted: task.isCompleted,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TaskDetailScreen(task: task),
                                  ),
                                );
                                if (context.mounted) {
                                  await taskProvider.fetchTasks();
                                }
                              },
                              onToggle: () {
                                taskProvider.updateTask(
                                  task.id,
                                  {'is_completed': !task.isCompleted},
                                );
                              },
                              onDelete: () {
                                taskProvider.deleteTask(task.id);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'إضافة مهمة',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
          if (context.mounted) {
            await context.read<TaskProvider>().fetchTasks();
          }
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'مهمة جديدة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}