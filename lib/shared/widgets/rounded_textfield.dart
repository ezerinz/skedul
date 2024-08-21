import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class RoundedTextField extends ConsumerWidget {
  const RoundedTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.digitOnly = false,
    this.obscure = false,
    this.readOnly = false,
    this.suffix,
    this.onTap,
    this.maxLines = 1,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  final bool digitOnly;
  final bool readOnly;
  final Widget? suffix;
  final Function()? onTap;
  final int? maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeChoosenProvider);
    return SizedBox(
      height: maxLines == 1 ? 48 : null,
      child: TextField(
        maxLines: maxLines,
        obscureText: obscure,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        cursorColor: isDark ? kColorDarkForeground : Colors.black,
        style: kTextMedium16,
        keyboardType: digitOnly ? TextInputType.number : null,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffix,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: maxLines == 1 ? 0 : 10.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 1.0,
              color: isDark ? kColorDarkForeground : Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 1.0,
              color: isDark ? kColorDarkForeground : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
