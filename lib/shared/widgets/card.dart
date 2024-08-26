import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';

class CustomCard extends ConsumerWidget {
  const CustomCard(
      {super.key,
      required this.title,
      this.titleWidget,
      this.percentColor,
      required this.subtitle1,
      required this.subtitle2,
      required this.backgroundColor,
      required this.foregroundColor,
      this.actionIcon,
      this.actionPressed,
      this.onCardTap});
  final String title;
  final Color? percentColor;
  final Widget? titleWidget;
  final String subtitle1;
  final String subtitle2;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? actionIcon;
  final Function()? actionPressed;
  final Function()? onCardTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: double.infinity,
        height: 81,
        color: backgroundColor.withOpacity(isDark ? 0.15 : 0.30),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                color: foregroundColor.withOpacity(
                  isDark ? 0.50 : 0.8,
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onCardTap,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (titleWidget != null) titleWidget!,
                        if (titleWidget == null)
                          Text(
                            title,
                            style: const TextStyle(
                                // color: foregroundColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        Row(
                          children: [
                            const Icon(
                              Icons.meeting_room,
                              size: 14,
                              // color: foregroundColor.withOpacity(0.75),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              child: Text(
                                subtitle1,
                                style: AppTheme.kTextSemiBold24.copyWith(
                                  fontSize: 14,
                                  // color: foregroundColor.withOpacity(0.75),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              // color: foregroundColor.withOpacity(0.75),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              child: Text(
                                subtitle2,
                                style: AppTheme.kTextSemiBold24.copyWith(
                                  fontSize: 14,
                                  // color: foregroundColor.withOpacity(0.75),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (actionIcon != null)
                SizedBox(
                  width: 50,
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    onTap: actionPressed,
                    child: Center(
                      child: Icon(
                        actionIcon!,
                        color: backgroundColor,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
