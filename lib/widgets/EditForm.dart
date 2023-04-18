import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';

enum EditFormType {
  add,
  edit,
}

class EditForm extends StatefulWidget {
  const EditForm({
    Key? key,
    required this.children,
    required this.type,
    this.onSave,
  }) : super(key: key);

  final List<Widget> children;
  final EditFormType type;
  final void Function()? onSave;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...widget.children.intersperse(const SizedBox(height: 12)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSave?.call();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          widget.type == EditFormType.add
                              ? 'Added'
                              : 'Applied',
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                  if (widget.type == EditFormType.edit) {
                    Navigator.pop(context);
                  }
                }
              },
              icon: Icon(
                  widget.type == EditFormType.add ? Icons.add : Icons.edit),
              label: Text(widget.type == EditFormType.add ? 'Add' : 'Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
