import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mini_budget/widgets/PageTemplate.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    this.title,
    this.child,
    this.page,
  }) : super(key: key);

  final String? title;
  final Widget? child;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: page != null,
      openBuilder: (context, action) => page != null
          ? page!
          : const PageTemplate(title: 'Not Implemented', children: []),
      closedColor: Theme.of(context).cardColor,
      closedElevation: 4,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      closedBuilder: (context, action) => Padding(
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
