import 'package:flutter/material.dart';
import 'package:mini_budget/utilities/Transaction.dart';
import 'package:mini_budget/widgets/EditForm.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';
import 'package:mini_budget/widgets/TransactionForm.dart';

class EditTransactionPage extends StatelessWidget {
  const EditTransactionPage({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Edit Transaction',
      isIntrinsicHeight: true,
      children: [
        TransactionForm(
          formType: EditFormType.edit,
          category: transaction.category,
          amount: transaction.amount,
          date: transaction.date,
          note: transaction.note,
          id: transaction.id,
        ),
      ],
    );
  }
}
