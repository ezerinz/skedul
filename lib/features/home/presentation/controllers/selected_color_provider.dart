import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/theme/colors.dart';

part 'selected_color_provider.g.dart';

@riverpod
class SelectedColor extends _$SelectedColor {
  @override
  Color build() {
    return kColorPrimary;
  }

  update(Color value) {
    state = value;
  }
}
