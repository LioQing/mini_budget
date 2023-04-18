import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/TitleBar.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({
    Key? key,
    required this.title,
    required this.children,
    this.scaffoldActionButton,
    this.buttonIcon = Icons.arrow_back,
    this.onButtonPressed,
    this.isIntrinsicHeight = false,
}) : super(key: key);

  final String title;
  final List<Widget> children;
  final Widget? scaffoldActionButton;
  final IconData buttonIcon;
  final void Function()? onButtonPressed;
  final bool isIntrinsicHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: _intrinsicHeightColumn([
              TitleBar(
                title: title,
                buttonIcon: buttonIcon,
                onButtonPressed: onButtonPressed != null
                  ? () => onButtonPressed!()
                  : () => Navigator.pop(context),
              ),
              ...children,
            ]),
          ),
        ),
      ),
      floatingActionButton: scaffoldActionButton,
    );
  }

  Widget _intrinsicHeightColumn(List<Widget> children) {
    if (!isIntrinsicHeight) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    }

    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}