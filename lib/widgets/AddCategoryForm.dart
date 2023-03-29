import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:mini_budget/utilities/Storage.dart';

// Category data
// Name (text)

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Storage>(
      builder: (context, storage, child) => Form(
        key: _formKey,
        child: Column(
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
                } else if (storage.categories.contains(Category(name: value))) {
                  return 'Category already exists';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  storage.addCategory(Category(name: value));
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding Category')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Add',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
