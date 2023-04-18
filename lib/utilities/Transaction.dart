import 'dart:convert';

// Transaction data
// Category (selection)
// Amount (number)
// Date (date)
// Note (text)

class Transaction {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final String note;

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
  });

  Transaction copyWith({
    String? id,
    String? category,
    double? amount,
    DateTime? date,
    String? note,
  }) {
    return Transaction(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, category: $category, amount: $amount, date: $date, note: $note)';
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'note': note,
    });
  }

  factory Transaction.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return Transaction(
      id: data['id'],
      category: data['category'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
      note: data['note'],
    );
  }
}