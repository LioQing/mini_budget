import 'package:flutter/material.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:mini_budget/utilities/Transaction.dart';
import 'package:provider/provider.dart';

class TransactionDataTable extends StatelessWidget {
  const TransactionDataTable({
    super.key,
    this.query = _defaultQuery,
    this.onTap,
  });

  final Iterable<Transaction> Function(Storage) query;
  final void Function(Transaction)? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
      builder: (context, storage, child) => LayoutBuilder(
        builder: (context, constraints) => DataTable(
          showCheckboxColumn: false,
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
                child: const Text('Category', textAlign: TextAlign.left, softWrap: true),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: (constraints.maxWidth - 20) * 0.3,
                child: const Text('Amount', textAlign: TextAlign.right, softWrap: true),
              ),
            ),
          ],
          rows: query(storage).map((transaction) {
            return DataRow(
              onSelectChanged: onTap != null
                ? (selected) {
                    if (selected == true) {
                      onTap?.call(transaction);
                    }
                  }
                : null,
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
                      textAlign: TextAlign.left,
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
    );
  }

  static Iterable<Transaction> _defaultQuery(Storage storage) => storage.transactions;
}