import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/text.dart';

class StatisticCard extends ConsumerWidget {
  const StatisticCard({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    this.leading,
    required this.number,
  });
  final Color backgroundColor;
  final Color foregroundColor;
  final String number;
  final Widget? leading;

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeChoosenProvider);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(isDark ? 0.15 : 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: [
          leading ??
              Text(
                number,
                style: kTextSemiBold24.copyWith(
                  fontSize: 40,
                  // color: foregroundColor,
                ),
              ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              text,
              style: kTextMedium18,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
