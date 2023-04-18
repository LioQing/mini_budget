import 'package:flutter/material.dart';
import 'package:mini_budget/utilities/Transaction.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';
import 'package:mini_budget/widgets/EditForm.dart';

// Transaction data
// Category (selection)
// Amount (number)
// Date (date)
// Note (text)

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    Key? key,
    required this.formType,
    this.category = 'Others',
    this.amount,
    this.date,
    this.note = '',
    this.id,
  }) : super(key: key);

  final EditFormType formType;
  final String category;
  final double? amount;
  final DateTime? date;
  final String note;
  final String? id;

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // transaction data
  String _category = 'Others';
  double? _amount;
  DateTime? _date;
  String _note = '';

  @override
  void initState() {
    super.initState();
    _category = widget.category;
    _amount = widget.amount;
    _date = widget.date;
    _note = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
      builder: (context, storage, child) => EditForm(
            type: widget.formType,
            onSave: () {
              if (widget.formType == EditFormType.add) {
                storage.addTransaction(Transaction(
                  id: DateTime
                      .now()
                      .millisecondsSinceEpoch
                      .toString(),
                  category: _category,
                  amount: _amount!,
                  date: _date != null ? _date! : DateTime.now(),
                  note: _note,
                ));
              } else {
                storage.updateTransaction(Transaction(
                  id: widget.id!,
                  category: _category,
                  amount: _amount!,
                  date: _date != null ? _date! : DateTime.now(),
                  note: _note,
                ));
              }
            },
            children: [
              DropdownButtonFormField(
                isExpanded: true,
                value: _category,
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
              TextFormField(
                initialValue: _amount?.toString(),
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
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                initialValue: _date ?? DateTime.now(),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                initialValue: _note,
                onSaved: (value) {
                  if (value != null) {
                    _note = value;
                  }
                },
              ),
            ],
          ),
    );
  }
}
