import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/category_provider.dart';
import '../widgets/app_badge.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _priority = 'medium';
  DateTime? _dueDate;
  int? _selectedCategoryId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<CategoryProvider>().fetchCategories();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(
        const Duration(days: 3650),
      ),
    );

    if (selectedDate == null || !mounted) {
      return;
    }

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _dueDate != null
          ? TimeOfDay.fromDateTime(_dueDate!)
          : TimeOfDay.now(),
    );

    if (selectedTime == null) {
      return;
    }

    setState(() {
      _dueDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final success = await context.read<TaskProvider>().addTask(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          priority: _priority,
          dueDate: _dueDate,
          categoryId: _selectedCategoryId,
        );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSaving = false;
    });

    if (success) {
      Navigator.pop(context, true);
      return;
    }

    final errorMessage = context.read<TaskProvider>().errorMessage;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage ?? 'حدث خطأ أثناء إضافة المهمة',
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'اضغط لتحديد تاريخ ووقت المهمة';
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$year/$month/$day  •  $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة مهمة جديدة'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  controller: _titleController,
                  label: 'عنوان المهمة *',
                  hintText: 'مثال: إنهاء متطلبات المشروع',
                  prefixIcon: Icons.edit_note_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال عنوان المهمة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                AppTextField(
                  controller: _descriptionController,
                  label: 'الوصف أو الملاحظات (اختياري)',
                  hintText: 'أضف تفاصيل إضافية عن المهمة...',
                  prefixIcon: Icons.notes_rounded,
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 22),
                Text(
                  'مستوى الأولوية',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AppChoiceChip<String>(
                        value: 'low',
                        selectedValue: _priority,
                        label: 'منخفضة 🟢',
                        activeColor: const Color(0xFF10B981),
                        onSelected: (val) => setState(() => _priority = val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppChoiceChip<String>(
                        value: 'medium',
                        selectedValue: _priority,
                        label: 'متوسطة 🟡',
                        activeColor: const Color(0xFFF59E0B),
                        onSelected: (val) => setState(() => _priority = val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppChoiceChip<String>(
                        value: 'high',
                        selectedValue: _priority,
                        label: 'عالية 🔴',
                        activeColor: const Color(0xFFEF4444),
                        onSelected: (val) => setState(() => _priority = val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Consumer<CategoryProvider>(
                  builder: (context, catProvider, _) {
                    return DropdownButtonFormField<int?>(
                      initialValue: _selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: 'التصنيف (اختياري)',
                        prefixIcon: const Icon(Icons.folder_outlined),
                        filled: true,
                        fillColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                          ),
                        ),
                      ),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('بدون تصنيف'),
                        ),
                        ...catProvider.categories.map(
                          (cat) => DropdownMenuItem<int?>(
                            value: cat.id,
                            child: Text(cat.name),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    onTap: _selectDueDate,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    title: const Text(
                      'موعد الاستحقاق',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _formatDate(_dueDate),
                      style: TextStyle(
                        fontSize: 14,
                        color: _dueDate == null
                            ? theme.colorScheme.onSurfaceVariant
                            : theme.colorScheme.primary,
                        fontWeight: _dueDate == null ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    trailing: _dueDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 20),
                            onPressed: () {
                              setState(() {
                                _dueDate = null;
                              });
                            },
                          )
                        : const Icon(Icons.chevron_left_rounded),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onPressed: _saveTask,
                  label: 'حفظ المهمة',
                  icon: Icons.add_task_rounded,
                  isLoading: _isSaving,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
