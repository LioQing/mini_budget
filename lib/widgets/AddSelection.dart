import 'package:flutter/material.dart';

enum AddSelectionType {
  transaction,
  category,
}

class AddSelection extends StatefulWidget {
  const AddSelection({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<AddSelectionType> onChanged;

  @override
  State<AddSelection> createState() => _AddSelectionState();
}

class _AddSelectionState extends State<AddSelection> {
  AddSelectionType selected = AddSelectionType.transaction;

  Widget _typeButton(BuildContext context, AddSelectionType type, IconData icon) {
    final typeString = type.toString().split('.').last;
    final buttonColor = selected == type ? Theme.of(context).primaryColor : Colors.grey;

    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() => selected = type);
          widget.onChanged(type);
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: buttonColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        icon: Icon(
            icon,
            size: 24,
            color: buttonColor,
        ),
        label: Text(
          '${typeString[0].toUpperCase()}${typeString.substring(1)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: buttonColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _typeButton(context, AddSelectionType.transaction, Icons.add),
          const SizedBox(width: 8),
          _typeButton(context, AddSelectionType.category, Icons.category),
        ],
      ),
    );
  }
}