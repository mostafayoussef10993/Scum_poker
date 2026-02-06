/*

class Vote {
  final String userId;
  final String name;
  final int? value;

  Vote({required this.userId, required this.name, this.value});

  factory Vote.fromMap(String id, Map<String, dynamic> map) {
    return Vote(
      userId: id,
      name: map['name'] as String? ?? id,
      value: map['value'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'value': value};
}
*/
