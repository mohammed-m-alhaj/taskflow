class TaskCategory {
  final int id;
  final int userId;
  final String name;
  final DateTime? createdAt;

  TaskCategory({
    required this.id,
    required this.userId,
    required this.name,
    this.createdAt,
  });

  factory TaskCategory.fromJson(Map<String, dynamic> json) {
    return TaskCategory(
      id: json['id'] != null ? (json['id'] as num).toInt() : 0,
      userId: json['user_id'] != null ? (json['user_id'] as num).toInt() : 1,
      name: json['name'] != null ? json['name'].toString() : '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
