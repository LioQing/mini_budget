import 'package:flutter/material.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:mini_budget/widgets/CategoryForm.dart';
import 'package:mini_budget/widgets/EditForm.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Edit Transaction',
      isIntrinsicHeight: true,
      children: [
        CategoryForm(
          formType: EditFormType.edit,
          category: category,
        ),
      ],
    );
  }
}