import 'package:flutter/material.dart';
import 'package:mini_budget/pages/EditTransactionPage.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:mini_budget/widgets/SlideUpPageRoute.dart';
import 'package:mini_budget/widgets/TransactionDataTable.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';

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
                  builder: (context) => SimpleDialog(
                    title: SelectableText.rich(
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
                    titlePadding: const EdgeInsets.all(24),
                    titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding: const EdgeInsets.all(24),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Back'),
                          ),
                          TextButton(
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
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
      ],
    );
  }
}
