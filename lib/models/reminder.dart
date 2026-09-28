class Reminder {
  final int id;
  final int taskId;
  final DateTime reminderTime;
  final bool isEnabled;
  final bool isSent;
  final DateTime? createdAt;

  Reminder({
    required this.id,
    required this.taskId,
    required this.reminderTime,
    this.isEnabled = true,
    this.isSent = false,
    this.createdAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    final enabled = json['is_enabled'] ?? true;
    final sent = json['is_sent'] ?? !enabled;
    return Reminder(
      id: json['id'] != null ? (json['id'] as num).toInt() : 0,
      taskId: json['task_id'] != null ? (json['task_id'] as num).toInt() : 0,
      reminderTime: json['reminder_time'] != null
          ? DateTime.tryParse(json['reminder_time'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isEnabled: enabled == 1 || enabled == true,
      isSent: sent == 1 || sent == true,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'reminder_time': reminderTime.toIso8601String(),
      'is_enabled': isEnabled,
      'is_sent': isSent,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
