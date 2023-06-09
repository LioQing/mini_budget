import 'package:flutter/material.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:provider/provider.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({
    super.key,
    this.onTap,
  });

  final void Function(Category)? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
      builder: (context, storage, child) {
        final amountThisMonth = storage.amountThisMonth;

        return LayoutBuilder(
          builder: (context, constraints) => DataTable(
            showCheckboxColumn: false,
            horizontalMargin: 0,
            columnSpacing: 10,
            columns: [
              DataColumn(
                label: SizedBox(
                  width: (constraints.maxWidth - 20) * 0.4,
                  child: const Text('Category', textAlign: TextAlign.left, softWrap: true),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: (constraints.maxWidth - 20) * 0.3,
                  child: const Text('Amount (This Month)', textAlign: TextAlign.right, softWrap: true),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: (constraints.maxWidth - 20) * 0.3,
                  child: const Text('Percentage (This Month)', textAlign: TextAlign.right, softWrap: true),
                ),
              ),
            ],
            rows: storage.categoriesWithAmountThisMonth.map((entry) {
              final category = entry.key;
              final amount = entry.value;
              return DataRow(
                onSelectChanged: onTap != null
                    ? (selected) {
                  if (selected == true) {
                    onTap?.call(entry.key);
                  }
                }
                    : null,
                cells: [
                  DataCell(
                    SizedBox(
                      width: (constraints.maxWidth - 20) * 0.4,
                      child: Text(
                        category.name,
                        textAlign: TextAlign.left,
                        softWrap: true,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: (constraints.maxWidth - 20) * 0.3,
                      child: Text(
                        Misc.formatCurrency(amount),
                        textAlign: TextAlign.right,
                        softWrap: true,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: (constraints.maxWidth - 20) * 0.3,
                      child: Text(
                        amountThisMonth == 0
                            ? 'N/A'
                            : '${(amount / amountThisMonth * 100).toStringAsFixed(2)}%',
                        textAlign: TextAlign.right,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}