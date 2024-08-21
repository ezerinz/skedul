import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:skedul/shared/theme/text.dart';

class DottedCard extends StatelessWidget {
  const DottedCard({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      radius: const Radius.circular(10.0),
      borderType: BorderType.RRect,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Icon(
                icon,
                size: 40,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: kTextMedium18.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
