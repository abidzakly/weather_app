class Todo {
  final int id;
  final String title;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String? updatedAt;

  Todo({required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.updatedAt});

  factory Todo.fromSqfliteDatabase(Map<String, dynamic> map) =>
      Todo(
          id: map['id']?.toInt() ?? 0,
          title: map['title'] ?? '',
          latitude: map['latitude'] ?? '',
          longitude: map['longitude'] ?? '',
          createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'])
              .toIso8601String(),
          updatedAt: map['updated_at'] == null ? null : DateTime.fromMillisecondsSinceEpoch(map['updated_at']).toIso8601String()
      );
}
