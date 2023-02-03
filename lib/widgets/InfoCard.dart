import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    this.title,
    this.child,
  }) : super(key: key);

  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: title != null ? 12 : 24, horizontal: 24),
        child: Column(
          children: [
            if (title != null) Align(
              alignment: Alignment.topLeft,
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
