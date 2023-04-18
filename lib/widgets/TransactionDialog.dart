import 'package:flutter/material.dart';
import 'package:mini_budget/pages/EditTransactionPage.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:mini_budget/utilities/Transaction.dart';
import 'package:mini_budget/widgets/SlideUpPageRoute.dart';

class TransactionDialog extends StatelessWidget {
  const TransactionDialog({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                    '${transaction.category}\n${transaction.date.toIso8601String().split('T').first}\n\n',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextSpan(
                    text:
                    'Amount: ${Misc.formatCurrency(transaction.amount)}\n\n',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: 'Note:\n${transaction.note}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  SlideUpPageRoute(
                    page: EditTransactionPage(
                      transaction: transaction,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
            ),
          ],
        ),
      ],
    );
  }
}
