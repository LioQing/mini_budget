import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/EditForm.dart';
import 'package:mini_budget/widgets/InfoCard.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';
import 'package:mini_budget/widgets/AddSelection.dart';
import 'package:mini_budget/widgets/TransactionForm.dart';
import 'package:mini_budget/widgets/CategoryForm.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  AddSelectionType formType = AddSelectionType.transaction;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Add',
      isIntrinsicHeight: true,
      children: [
        AddSelection(
            onChanged: (type) => setState(() => formType = type)),
        const SizedBox(height: 36),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: child.key ==
                    const ValueKey(AddSelectionType.transaction)
                    ? const Offset(-1.1, 0)
                    : const Offset(1.1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            ),
            child: Column(
              key: ValueKey(formType),
              children: [
                InfoCard(
                  child: formType == AddSelectionType.transaction
                      ? const TransactionForm(formType: EditFormType.add)
                      : const CategoryForm(formType: EditFormType.add),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
