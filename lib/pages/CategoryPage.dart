import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/CategoryDataTable.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      title: 'Category',
      children: [
        CategoryDataTable(),
      ],
    );
  }
}