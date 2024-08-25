import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/widgets/card.dart';

class SlidableCard extends ConsumerStatefulWidget {
  const SlidableCard(
      {super.key,
      this.delete,
      this.edit,
      required this.title,
      this.percentColor,
      this.titleWidget,
      required this.subtitle1,
      required this.subtitle2,
      required this.backgroundColor,
      required this.foregroundColor,
      this.onCardTap,
      this.slidable = true});

  final Function()? delete;
  final Function()? edit;
  final String title;
  final Color? percentColor;
  final Widget? titleWidget;
  final String subtitle1;
  final String subtitle2;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function()? onCardTap;
  final bool slidable;

  @override
  ConsumerState<SlidableCard> createState() => _SlidableCardState();
}

class _SlidableCardState extends ConsumerState<SlidableCard> {
  final slideCtrl = SlideController(usePostActionController: true);
  ActionPosition? position;

  @override
  void initState() {
    super.initState();
    slideCtrl.addListener(() {
      setState(() {
        position = slideCtrl.openedPosition;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    slideCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkModeProvider);
    return SlidablePanel(
      controller: slideCtrl,
      gestureDisabled: !widget.slidable,
      maxSlideThreshold: 0.55,
      postActions: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              height: 81,
              width: 81,
              child: Material(
                color:
                    AppTheme.kColorSecondary.withOpacity(isDark ? 0.15 : 0.30),
                child: InkWell(
                  onTap: () {
                    slideCtrl.dismiss();
                    if (widget.delete != null) {
                      widget.delete!();
                    }
                  },
                  child: Icon(
                    Icons.delete,
                    size: 28,
                    color: isDark
                        ? AppTheme.kColorDarkForeground
                        : const Color(0xFF1B1A1B).withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              height: 81,
              width: 81,
              child: Material(
                color: AppTheme.kColorPrimary.withOpacity(isDark ? 0.15 : 0.30),
                child: InkWell(
                  onTap: () {
                    slideCtrl.dismiss();
                    if (widget.edit != null) {
                      widget.edit!();
                    }
                  },
                  child: Icon(
                    Icons.edit,
                    size: 28,
                    color: isDark
                        ? AppTheme.kColorDarkForeground
                        : const Color(0xFF1B1A1B).withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      child: CustomCard(
        title: widget.title,
        subtitle1: widget.subtitle1,
        subtitle2: widget.subtitle2,
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        actionIcon: widget.slidable
            ? position == ActionPosition.post
                ? Icons.close
                : Icons.arrow_back_ios_new
            : null,
        actionPressed: widget.slidable
            ? () {
                if (position == ActionPosition.post) {
                  slideCtrl.dismiss();
                } else {
                  slideCtrl.open(position: ActionPosition.post);
                }
              }
            : null,
        onCardTap: widget.onCardTap,
      ),
    );
  }
}
