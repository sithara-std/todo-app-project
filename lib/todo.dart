class Todo {
  String id;
  String title;
  String description;
  DateTime? dueDate;
  String priority;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    this.priority = 'Low',
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(String id, Map<String, dynamic> map) {
    return Todo(
      id: id,
      title: map['title'],
      description: map['description'] ?? '',
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      priority: map['priority'] ?? 'Low',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}