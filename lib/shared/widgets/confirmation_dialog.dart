import 'package:flutter/material.dart';
import 'package:skedul/shared/utils/extensions.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.buttons,
    required this.title,
    required this.subtitle,
  });
  final Widget title;
  final Widget subtitle;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title,
          subtitle,
          const SizedBox(
            height: 10,
          ),
          Row(
            children: buttons
                .map((e) => Expanded(child: e))
                .toList()
                .withSpaceBetween(
                  width: 10.0,
                ),
          )
        ],
      ),
    );
  }
}
