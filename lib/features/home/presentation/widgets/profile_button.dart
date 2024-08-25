import 'package:flutter/material.dart';
import 'package:skedul/shared/theme/theme.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, this.onPressed, required this.text});
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: AppTheme.kTextMedium16,
          ),
        ),
      ),
    );
  }
}
