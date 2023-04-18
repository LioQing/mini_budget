import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/EditForm.dart';
import 'package:provider/provider.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:mini_budget/utilities/Storage.dart';

// Category data
// Name (text)

class CategoryForm extends StatefulWidget {
  const CategoryForm({
    Key? key,
    required this.formType,
    this.category,
  }) : super(key: key);

  final EditFormType formType;
  final Category? category;

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
        builder: (context, storage, child) => EditForm(
              type: widget.formType,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    } else if (value == 'Others') {
                      return '\'Others\' is a reserved category name';
                    } else if (storage.categories
                        .contains(Category(name: value))) {
                      return 'Category already exists';
                    }
                    return null;
                  },
                  initialValue: widget.category?.name,
                  onSaved: (value) {
                    if (value != null) {
                      if (widget.formType == EditFormType.add) {
                        storage.addCategory(Category(name: value));
                      } else if (widget.formType == EditFormType.edit) {
                        storage.renameCategory(
                            widget.category!,
                            Category(name: value),
                            true,
                        );
                      }
                    }
                  },
                ),
              ],
            ));
  }
}
