import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/InfoCard.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:mini_budget/utilities/Misc.dart';
import 'package:provider/provider.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Overview',
      child: Consumer<Storage>(
        builder: (context, storage, child) => Column(
          children: [
            Text(
              Misc.formatCurrency(storage.amountThisMonth),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              'out of 0000',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Text(
              '(100%)',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}