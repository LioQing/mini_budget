import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/InfoCard.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Overview',
      child: Column(
        children: const [
          Text(
            '0000',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'out of 0000',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '(100%)',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}