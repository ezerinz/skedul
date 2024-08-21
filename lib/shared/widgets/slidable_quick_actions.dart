import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class SlidableQuickActions extends ConsumerWidget {
  const SlidableQuickActions(
      {super.key,
      required this.controller,
      this.groupTag,
      required this.delete,
      required this.edit,
      required this.child});

  final SlidableController controller;
  final String? groupTag;
  final Function()? delete;
  final Function(BuildContext)? edit;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeChoosenProvider);
    return Slidable(
      groupTag: groupTag,
      controller: controller,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          const SizedBox(
            width: 8.0,
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black38,
                context: context,
                builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2.0),
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: isDark ? null : Colors.white,
                      surfaceTintColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Menghapus",
                              style: kTextMedium18,
                            ),
                            const Text(
                              "Kamu yakin ingin menghapus?",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: isDark
                                          ? kColorDarkForeground
                                          : kColorDark,
                                      surfaceTintColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: isDark
                                                ? kColorDarkForeground
                                                : kColorDark,
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text("Batal"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: delete,
                                    style: TextButton.styleFrom(
                                      foregroundColor: isDark
                                          ? kColorDarkForeground
                                          : kColorDark,
                                      surfaceTintColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: isDark
                                                ? kColorDarkForeground
                                                : kColorDark,
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Hapus",
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icons.delete,
            backgroundColor: kColorSecondary.withOpacity(isDark ? 0.15 : 0.30),
            foregroundColor: isDark
                ? kColorDarkForeground
                : const Color(0xFF1B1A1B).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.0),
          ),
          const SizedBox(
            width: 8.0,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(10.0),
            backgroundColor: kColorPrimary.withOpacity(isDark ? 0.15 : 0.30),
            foregroundColor: isDark
                ? kColorDarkForeground
                : const Color(0xFF1B1A1B).withOpacity(0.7),
            onPressed: edit,
            icon: Icons.edit,
          ),
        ],
      ),
      child: child,
    );
  }
}
