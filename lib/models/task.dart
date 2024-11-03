class Task {
  int id;
  String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['userId'],
      title: json['title'],
      isCompleted: json['completed'],
    );
  }
}
