import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/TransactionDataTable.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';
import 'package:mini_budget/widgets/TransactionDialog.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Transaction',
      children: [
        TransactionDataTable(
            onTap: (transaction) => showDialog(
                  context: context,
                  builder: (context) => TransactionDialog(transaction: transaction),
                ),
        ),
      ],
    );
  }
}

