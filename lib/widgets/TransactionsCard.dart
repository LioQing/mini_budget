import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/InfoCard.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:provider/provider.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Transactions',
      child: Consumer<Storage>(
        builder: (context, storage, child) => LayoutBuilder(
          builder: (context, constraints) => DataTable(
            horizontalMargin: 0,
            columnSpacing: 10,
            columns: [
              DataColumn(
                label: SizedBox(
                  width: (constraints.maxWidth - 20) * 0.3,
                  child: const Text('Date', textAlign: TextAlign.left, softWrap: true),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: (constraints.maxWidth - 20) * 0.4,
                  child: const Text('Category', textAlign: TextAlign.center, softWrap: true),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: (constraints.maxWidth - 20) * 0.3,
                  child: const Text('Amount', textAlign: TextAlign.right, softWrap: true),
                ),
              ),
            ],
            rows: storage.transactions
              .sublist(0, storage.transactions.length > 10 ? 10 : storage.transactions.length)
              .map((transaction) {
                return DataRow(
                  cells: [
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 20) * 0.3,
                        child: Text(
                          // date in the format of yyyy-mm-dd
                          transaction.date.toIso8601String().split('T').first,
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 20) * 0.4,
                        child: Text(
                          transaction.category,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 20) * 0.3,
                        child: Text(
                          Misc.formatCurrency(transaction.amount),
                          textAlign: TextAlign.right,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                );
              })
              .toList(),
          ),
        ),
      ),
    );
  }
}