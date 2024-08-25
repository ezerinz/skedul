import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';

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
    this.focusNode,
    this.inputFormatters,
    this.textStyle,
    this.textAlign,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  final bool digitOnly;
  final bool readOnly;
  final Widget? suffix;
  final Function()? onTap;
  final int? maxLines;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);
    return SizedBox(
      height: maxLines == 1 ? 48 : null,
      child: TextField(
        textAlign: textAlign ?? TextAlign.left,
        focusNode: focusNode,
        maxLines: maxLines,
        obscureText: obscure,
        inputFormatters: inputFormatters,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        cursorColor: isDark ? AppTheme.kColorDarkForeground : Colors.black,
        style: textStyle ?? AppTheme.kTextMedium16,
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
              color: isDark ? AppTheme.kColorDarkForeground : Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 1.0,
              color: isDark ? AppTheme.kColorDarkForeground : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
