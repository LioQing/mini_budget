import 'dart:convert';

// Transaction data
// Category (selection)
// Amount (number)
// Date (date)
// Remarks (text)

class Transaction {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final String remarks;

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.remarks,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, category: $category, amount: $amount, date: $date, remarks: $remarks)';
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'remarks': remarks,
    });
  }

  factory Transaction.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return Transaction(
      id: data['id'],
      category: data['category'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
      remarks: data['remarks'],
    );
  }
}