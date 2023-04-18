import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
    required this.title,
    this.buttonIcon,
    this.onButtonPressed,
  }) : super(key: key);

  final String title;
  final IconData? buttonIcon;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: buttonIcon != null
                  ? IconButton(
                    icon: Icon(buttonIcon!),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                  : const SizedBox(),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}