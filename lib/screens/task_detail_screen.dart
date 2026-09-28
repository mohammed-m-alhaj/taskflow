import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../models/subtask.dart';
import '../models/reminder.dart';
import '../providers/task_provider.dart';
import '../providers/reminder_provider.dart';
import '../providers/category_provider.dart';
import '../widgets/app_shimmer.dart';
import '../widgets/app_badge.dart';
import '../services/ai_service.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _priority;
  late String _status;
  late DateTime? _dueDate;
  late TimeOfDay? _dueTime;
  late bool _isCompleted;

  bool _isEditing = false;
  bool _isSaving = false;

  final List<Subtask> _subtasks = [];
  bool _isLoadingSubtasks = false;

  final List<Reminder> _reminders = [];
  bool _isLoadingReminders = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description ?? '');
    _priority = widget.task.priority;
    _status = widget.task.status;
    _dueDate = widget.task.dueDate;
    _dueTime = widget.task.dueDate != null
        ? TimeOfDay.fromDateTime(widget.task.dueDate!)
        : null;
    _isCompleted = widget.task.isCompleted;
    _loadSubtasks();
    _loadReminders();
  }

  Future<void> _loadSubtasks() async {
    setState(() => _isLoadingSubtasks = true);
    try {
      final list =
          await context.read<TaskProvider>().fetchSubtasks(widget.task.id);
      if (!mounted) return;
      setState(() {
        _subtasks.clear();
        _subtasks.addAll(list);
      });
    } catch (_) {}
    if (mounted) {
      setState(() => _isLoadingSubtasks = false);
    }
  }

  Future<void> _loadReminders() async {
    setState(() => _isLoadingReminders = true);
    try {
      final list = await context
          .read<ReminderProvider>()
          .fetchRemindersForTask(widget.task.id);
      if (!mounted) return;
      setState(() {
        _reminders.clear();
        _reminders.addAll(list);
      });
    } catch (_) {}
    if (mounted) {
      setState(() => _isLoadingReminders = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _dueTime = picked);
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    DateTime? combinedDueDate;
    if (_dueDate != null) {
      final time = _dueTime ?? const TimeOfDay(hour: 23, minute: 59);
      combinedDueDate = DateTime(
        _dueDate!.year,
        _dueDate!.month,
        _dueDate!.day,
        time.hour,
        time.minute,
      );
    }

    final updateFields = <String, dynamic>{
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'priority': _priority,
      'status': _status,
      'is_completed': _isCompleted,
      'due_date': combinedDueDate?.toIso8601String(),
    };

    final success = await context.read<TaskProvider>().updateTask(
          widget.task.id,
          updateFields,
        );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
      if (success) _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'تم تحديث المهمة بنجاح' : 'فشل تحديث المهمة',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _toggleCompleted() async {
    final newValue = !_isCompleted;

    final success = await context.read<TaskProvider>().updateTask(
      widget.task.id,
      {'is_completed': newValue},
    );

    if (!mounted) return;

    if (success) {
      setState(() => _isCompleted = newValue);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            newValue ? 'تم إكمال المهمة ✅' : 'تم إلغاء الإكمال',
          ),
        ),
      );
    }
  }

  Future<void> _deleteTask() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف المهمة'),
        content: const Text('هل تريد حذف هذه المهمة نهائيًا؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final success =
        await context.read<TaskProvider>().deleteTask(widget.task.id);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف المهمة')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('فشل حذف المهمة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _addSubtaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مهمة فرعية'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'عنوان الخطوة الفرعية...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                Navigator.pop(ctx);
                final newSub = await context
                    .read<TaskProvider>()
                    .addSubtask(widget.task.id, text);
                if (newSub != null && mounted) {
                  setState(() {
                    _subtasks.add(newSub);
                  });
                }
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAiSubtasks() async {
    setState(() => _isLoadingSubtasks = true);
    try {
      final subtaskTitles =
          await AiService().generateSubtasksForTask(widget.task.title);
      if (!mounted) return;
      final taskProvider = context.read<TaskProvider>();
      for (final title in subtaskTitles) {
        final newSub = await taskProvider.addSubtask(widget.task.id, title);
        if (newSub != null && mounted) {
          _subtasks.add(newSub);
        }
      }
      if (mounted) {
        setState(() => _isLoadingSubtasks = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('تم توليد وتوزيع خطوات المهمة بالذكاء الاصطناعي بنجاح! ✨'),
            backgroundColor: Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingSubtasks = false);
      }
    }
  }

  Future<void> _addReminderDialog() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null || !mounted) return;

    final reminderDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    final created = await context
        .read<ReminderProvider>()
        .createReminder(widget.task.id, reminderDateTime);
    if (created != null && mounted) {
      setState(() {
        _reminders.add(created);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت إضافة التذكير بنجاح')),
      );
    }
  }

  String _priorityLabel(String value) {
    switch (value) {
      case 'high':
        return 'عالية 🔴';
      case 'medium':
        return 'متوسطة 🟡';
      case 'low':
        return 'منخفضة 🟢';
      default:
        return value;
    }
  }

  String _statusLabel(String value) {
    switch (value) {
      case 'pending':
        return 'قيد الانتظار';
      case 'in_progress':
        return 'قيد التنفيذ';
      case 'completed':
        return 'مكتملة';
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المهمة'),
        actions: [
          if (!_isEditing)
            IconButton(
              onPressed: () => setState(() => _isEditing = true),
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'تعديل',
            ),
          IconButton(
            onPressed: _deleteTask,
            icon: const Icon(Icons.delete_outline),
            tooltip: 'حذف',
            color: Colors.red,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _isEditing ? _buildEditForm() : _buildDetailView(),
      ),
    );
  }

  Widget _buildDetailView() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final completedSubtasks = _subtasks.where((s) => s.isCompleted).length;
    final totalSubtasks = _subtasks.length;
    final progress = totalSubtasks > 0 ? (completedSubtasks / totalSubtasks) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggleCompleted,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _isCompleted
                  ? (isDark ? Colors.green.withAlpha(40) : const Color(0xFFE8F5E9))
                  : (isDark ? Colors.amber.withAlpha(40) : const Color(0xFFFFF8E1)),
              border: Border.all(
                color: _isCompleted
                    ? (isDark ? Colors.green.shade600 : Colors.green.shade300)
                    : (isDark ? Colors.amber.shade700 : Colors.amber.shade300),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: _isCompleted ? Colors.green : Colors.amber.shade800,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  _isCompleted ? 'مكتملة' : 'غير مكتملة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isCompleted
                        ? (isDark ? Colors.green.shade300 : Colors.green.shade800)
                        : (isDark ? Colors.amber.shade300 : Colors.amber.shade900),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'اضغط للتبديل',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withAlpha(160),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _titleController.text,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            decoration: _isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        const SizedBox(height: 12),
        if (_descriptionController.text.isNotEmpty) ...[
          Text(
            'الوصف',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _descriptionController.text,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
          const SizedBox(height: 18),
        ],
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppInfoChip(
              icon: Icons.flag_rounded,
              label: _priorityLabel(_priority),
            ),
            AppInfoChip(
              icon: Icons.hourglass_bottom_rounded,
              label: _statusLabel(_status),
            ),
            if (_dueDate != null)
              AppInfoChip(
                icon: Icons.calendar_today_rounded,
                label: '${_dueDate!.year}/${_dueDate!.month}/${_dueDate!.day}',
              ),
            if (_dueTime != null)
              AppInfoChip(
                icon: Icons.access_time_rounded,
                label: _dueTime!.format(context),
              ),
            if (widget.task.categoryId != null)
              Consumer<CategoryProvider>(
                builder: (context, catProvider, _) {
                  final cat = catProvider.getCategoryById(widget.task.categoryId);
                  if (cat == null) return const SizedBox.shrink();
                  return AppInfoChip(
                    icon: Icons.folder_rounded,
                    label: cat.name,
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 8,
          children: [
            Text(
              'المهام الفرعية ($completedSubtasks/$totalSubtasks)',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton.icon(
                  onPressed: _isLoadingSubtasks ? null : _generateAiSubtasks,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    visualDensity: VisualDensity.compact,
                    side: const BorderSide(color: Color(0xFF2563EB)),
                    foregroundColor: const Color(0xFF2563EB),
                  ),
                  icon: const Icon(Icons.auto_awesome, size: 16),
                  label: const Text('توليد بالذكاء الاصطناعي ✨', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 8),
                FilledButton.tonalIcon(
                  onPressed: _addSubtaskDialog,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('إضافة خطوة', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
        if (totalSubtasks > 0) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'نسبة الإنجاز: ${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: progress == 1.0
                      ? const Color(0xFF10B981)
                      : theme.colorScheme.primary,
                ),
              ),
              if (progress == 1.0)
                const Text(
                  'مكتملة بالكامل! 🎯',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF10B981),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress == 1.0 ? const Color(0xFF10B981) : const Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (_isLoadingSubtasks)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ShimmerTaskList(count: 2),
          )
        else if (_subtasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withAlpha(90),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(80)),
            ),
            child: Center(
              child: Text(
                'لا توجد خطوات فرعية بعد. اضغط "إضافة خطوة" لتقسيم المهمة',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13),
              ),
            ),
          )
        else
          ..._subtasks.asMap().entries.map((entry) {
            final idx = entry.key;
            final subtask = entry.value;
            return AppActionTile(
              leading: Checkbox(
                value: subtask.isCompleted,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (val) async {
                  final newCompleted = val ?? false;
                  final success = await context
                      .read<TaskProvider>()
                      .toggleSubtask(subtask.id, newCompleted);
                  if (success && mounted) {
                    setState(() {
                      _subtasks[idx] =
                          subtask.copyWith(isCompleted: newCompleted);
                    });
                  }
                },
              ),
              title: Text(
                subtask.title,
                style: TextStyle(
                  decoration:
                      subtask.isCompleted ? TextDecoration.lineThrough : null,
                  color: subtask.isCompleted
                      ? theme.colorScheme.onSurface.withAlpha(120)
                      : null,
                  fontWeight: subtask.isCompleted ? FontWeight.normal : FontWeight.w500,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () async {
                  final success = await context
                      .read<TaskProvider>()
                      .deleteSubtask(subtask.id);
                  if (success && mounted) {
                    setState(() => _subtasks.removeAt(idx));
                  }
                },
              ),
            );
          }),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'التذكيرات (${_reminders.length})',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: _addReminderDialog,
              icon: const Icon(Icons.add_alarm_rounded, size: 18),
              label: const Text('إضافة تذكير'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_isLoadingReminders)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ShimmerTaskList(count: 2),
          )
        else if (_reminders.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withAlpha(90),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(80)),
            ),
            child: Center(
              child: Text(
                'لا توجد تذكيرات محددة لهذه المهمة',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13),
              ),
            ),
          )
        else
          ..._reminders.asMap().entries.map((entry) {
            final idx = entry.key;
            final reminder = entry.value;
            final formatted =
                DateFormat('yyyy/MM/dd - hh:mm a').format(reminder.reminderTime);
            return AppActionTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.alarm_rounded, color: Colors.blue, size: 20),
              ),
              title: Text(formatted, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () async {
                  final success = await context
                      .read<ReminderProvider>()
                      .deleteReminder(reminder.id);
                  if (success && mounted) {
                    setState(() => _reminders.removeAt(idx));
                  }
                },
              ),
            );
          }),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => setState(() => _isEditing = true),
            icon: const Icon(Icons.edit_note_rounded),
            label: const Text(
              'تعديل المهمة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _titleController,
            label: 'عنوان المهمة',
            prefixIcon: Icons.title,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'أدخل عنوان المهمة';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _descriptionController,
            label: 'الوصف (اختياري)',
            prefixIcon: Icons.description,
            minLines: 3,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _priority,
            decoration: const InputDecoration(
              labelText: 'الأولوية',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.flag_outlined),
            ),
            items: const [
              DropdownMenuItem(value: 'high', child: Text('عالية 🔴')),
              DropdownMenuItem(value: 'medium', child: Text('متوسطة 🟡')),
              DropdownMenuItem(value: 'low', child: Text('منخفضة 🟢')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _priority = value);
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: const InputDecoration(
              labelText: 'الحالة',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.hourglass_bottom),
            ),
            items: const [
              DropdownMenuItem(value: 'pending', child: Text('قيد الانتظار')),
              DropdownMenuItem(
                  value: 'in_progress', child: Text('قيد التنفيذ')),
              DropdownMenuItem(value: 'completed', child: Text('مكتملة')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _status = value);
            },
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('مكتملة'),
            subtitle: const Text('تبديل حالة الإكمال'),
            value: _isCompleted,
            onChanged: (value) => setState(() => _isCompleted = value),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(
              _dueDate != null
                  ? '${_dueDate!.year}/${_dueDate!.month}/${_dueDate!.day}'
                  : 'بدون تاريخ',
            ),
            subtitle: const Text('تاريخ الاستحقاق'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.edit_calendar),
                ),
                if (_dueDate != null)
                  IconButton(
                    onPressed: () => setState(() {
                      _dueDate = null;
                      _dueTime = null;
                    }),
                    icon: const Icon(Icons.clear),
                  ),
              ],
            ),
          ),
          if (_dueDate != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: Text(
                _dueTime != null
                    ? _dueTime!.format(context)
                    : 'بدون وقت',
              ),
              subtitle: const Text('وقت الاستحقاق'),
              trailing: IconButton(
                onPressed: _pickTime,
                icon: const Icon(Icons.edit),
              ),
            ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSaving
                      ? null
                      : () => setState(() => _isEditing = false),
                  child: const Text('إلغاء'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: AppButton(
                  onPressed: _saveChanges,
                  label: 'حفظ التعديلات',
                  isLoading: _isSaving,
                  height: 48,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
