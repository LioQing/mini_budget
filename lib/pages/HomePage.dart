import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mini_budget/pages/AddPage.dart';
import 'package:mini_budget/widgets/CategoryCard.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';
import 'package:mini_budget/widgets/OverviewCard.dart';
import 'package:mini_budget/widgets/TransactionCard.dart';
import 'package:mini_budget/utilities/Storage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
      builder: (context, storage, child) => PageTemplate(
        title: 'Mini Budget',
        buttonIcon: Icons.settings,
        onButtonPressed: () {
          // print storage transactions and categories
          print(storage.transactions);
          print(storage.categories);
        },
        scaffoldActionButton: OpenContainer(
          openBuilder: (BuildContext context, VoidCallback _) {
            return const AddPage();
          },
          closedElevation: 4.0,
          closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
          closedColor: Theme.of(context).colorScheme.secondary,
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return SizedBox(
              width: 56,
              height: 56,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            );
          },
        ),
        children: const [
          OverviewCard(),
          SizedBox(height: 16),
          TransactionCard(),
          SizedBox(height: 16),
          CategoryCard(),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
