import 'package:flutter/material.dart';
import 'package:mini_budget/pages/EditCategoryPage.dart';
import 'package:mini_budget/widgets/CategoryDataTable.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Category',
      children: [
        CategoryDataTable(
            onTap: (category) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditCategoryPage(category: category),
              ),
            ),
        ),
      ],
    );
  }
}