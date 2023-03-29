import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/InfoCard.dart';
import 'package:mini_budget/widgets/TitleBar.dart';
import 'package:mini_budget/widgets/AddSelection.dart';
import 'package:mini_budget/widgets/AddTransactionForm.dart';
import 'package:mini_budget/widgets/AddCategoryForm.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  AddSelectionType formType = AddSelectionType.transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleBar(
                title: 'Add',
                buttonIcon: Icons.close,
                onButtonPressed: () => Navigator.pop(context),
              ),
              AddSelection(onChanged: (type) => setState(() => formType = type)),
              const SizedBox(height: 36),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: child.key == const ValueKey(AddSelectionType.transaction)
                        ? const Offset(-1.1, 0) : const Offset(1.1, 0),
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
                            ? const AddTransactionForm()
                            : const AddCategoryForm(),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}