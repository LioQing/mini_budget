import 'package:flutter/material.dart';
import 'package:mini_budget/pages/AddPage.dart';
import 'package:mini_budget/widgets/CategoriesCard.dart';
import 'package:mini_budget/widgets/TitleBar.dart';
import 'package:mini_budget/widgets/OverviewCard.dart';
import 'package:mini_budget/widgets/TransactionsCard.dart';
import 'package:mini_budget/widgets/SlideUpPageRoute.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<Storage>(
                  builder: (context, storage, child) => TitleBar(
                    title: 'Mini Budget',
                    buttonIcon: Icons.settings,
                    onButtonPressed: () {
                      // print storage transactions and categories
                      print(storage.transactions);
                      print(storage.categories);
                    },
                  ),
                ),
                const OverviewCard(),
                const SizedBox(height: 16),
                const TransactionsCard(),
                const SizedBox(height: 16),
                const CategoriesCard(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            SlideUpPageRoute(page: const AddPage()),
          );
        },
        tooltip: 'Add',
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
