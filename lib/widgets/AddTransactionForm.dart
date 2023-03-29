import 'package:flutter/material.dart';
import 'package:mini_budget/utilities/Transaction.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

// Transaction data
// Category (selection)
// Amount (number)
// Date (date)
// Remarks (text)

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({Key? key}) : super(key: key);

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  // transaction data
  String _category = 'Others';
  double? _amount;
  DateTime? _date;
  String _remarks = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
      builder: (context, storage, child) => Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField(
              isExpanded: true,
              items: storage.categories.map((category) {
                return DropdownMenuItem(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !storage.categories.contains(Category(name: value))) {
                  return 'Please select a category';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  _category = value;
                }
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r'^\d+(\.\d(\d)?)?$').hasMatch(value)) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  _amount = double.parse(value);
                }
              },
            ),
            const SizedBox(height: 12),
            DateTimeFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
              mode: DateTimeFieldPickerMode.date,
              autovalidateMode: AutovalidateMode.always,
              initialValue: DateTime.now(),
              validator: (value) {
                if (value == null) {
                  return 'Please select a date';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  _date = value;
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding Transaction')),
                  );

                  _formKey.currentState!.save();
                  storage.addTransaction(Transaction(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    category: _category,
                    amount: _amount!,
                    date: _date != null ? _date! : DateTime.now(),
                    remarks: _remarks,
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Add',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
