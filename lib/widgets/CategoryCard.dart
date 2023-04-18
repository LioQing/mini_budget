import 'package:flutter/material.dart';
import 'package:mini_budget/pages/CategoryPage.dart';
import 'package:mini_budget/widgets/CategoryDataTable.dart';
import 'package:mini_budget/widgets/InfoCard.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InfoCard(
      title: 'Category',
      page: CategoryPage(),
      child: CategoryDataTable(),
    );
  }
}
