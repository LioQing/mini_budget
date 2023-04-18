import 'dart:convert';

// Category data
// Name (text)

class Category {

  final String name;
  static final Category others = Category(name: 'Others');

  Category({
    required this.name,
  });

  Category copyWith({
    String? name,
  }) {
    return Category(
      name: name ?? this.name,
    );
  }

  @override
  bool operator==(Object other) {
    if (identical(this, other)) return true;
    if (other is String) return other == name;
    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Category(name: $name)';
  }

  String toJson() {
    return jsonEncode({
      'name': name,
    });
  }

  factory Category.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return Category(
      name: data['name'],
    );
  }
}