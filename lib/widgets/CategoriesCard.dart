import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/InfoCard.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:provider/provider.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Categories',
      child: Consumer<Storage>(
        builder: (context, storage, child) {
          final amountThisMonth = storage.amountThisMonth;

          return LayoutBuilder(
            builder: (context, constraints) => DataTable(
              horizontalMargin: 0,
              columnSpacing: 10,
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: (constraints.maxWidth - 20) * 0.3,
                    child: const Text('Category', textAlign: TextAlign.left, softWrap: true),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: (constraints.maxWidth - 20) * 0.4,
                    child: const Text('Amount (This Month)', textAlign: TextAlign.center, softWrap: true),
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
                  cells: [
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 20) * 0.3,
                        child: Text(
                          category.name,
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 20) * 0.4,
                        child: Text(
                          Misc.formatCurrency(amount),
                          textAlign: TextAlign.center,
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
      ),
    );
  }
}
