
class Task {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.dueDate,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'dueDate': dueDate,
  };

  static Task fromMap(Map<String, dynamic> map, String id) => Task(
    id: id,
    title: map['title'],
    description: map['description'] ?? '',
    isCompleted: map['isCompleted'] ?? false,
    dueDate: map['dueDate']?.toDate(),
  );
}
