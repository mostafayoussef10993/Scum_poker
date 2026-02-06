class SessionModel {
  final String id;
  final String name;
  final DateTime createdAt;

  SessionModel({required this.id, required this.name, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'createdAt': createdAt.toIso8601String()};
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      id: map['id'],
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
