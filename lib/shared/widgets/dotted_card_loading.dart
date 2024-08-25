import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:skedul/shared/theme/theme.dart';

class DottedCardLoading extends StatelessWidget {
  const DottedCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: DottedBorder(
        color: Colors.grey,
        radius: const Radius.circular(10.0),
        borderType: BorderType.RRect,
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(color: AppTheme.kColorPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
