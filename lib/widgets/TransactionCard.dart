import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_budget/pages/TransactionPage.dart';
import 'package:mini_budget/widgets/InfoCard.dart';
import 'package:mini_budget/widgets/TransactionDataTable.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Transaction',
      page: const TransactionPage(),
      child: TransactionDataTable(
          query: (storage) => storage.transactions
              .sublist(0, min(storage.transactions.length, 10))),
    );
  }
}
