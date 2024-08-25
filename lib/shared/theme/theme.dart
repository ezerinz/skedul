import 'package:flutter/material.dart';
import 'package:skedul/shared/utils/utils.dart';

class AppTheme {
  static const kColorPrimarySilver = Color(0xFFc0c0c0);
  static const kColorPrimary = Color(0xFF60DFA9);
  static const kColorPrimaryDeep = Color(0xFF0B5033);
  static const kColorSecondary = Color(0xFFFF8D94);
  static const kColorSecondaryDeep = Color(0xFF8F272E);
  static const kColorDark = Color(0xFF1B1A1F);
  static const kColorDarkForeground = Color(0xFFDFDADE);

  static const fontFamily = "KumbhSans";
  static const kTextSemiBold24 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static const kTextSemiBold18 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const kTextMedium16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const kTextMedium18 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const navigatorBarThemeData = NavigationBarThemeData(
    backgroundColor: Colors.transparent,
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    indicatorColor: Colors.transparent,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
  );

  static final themeData = ThemeData(
    useMaterial3: true,
    primarySwatch: generateMaterialColor(Colors.white),
    fontFamily: fontFamily,
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black87,
      elevation: 2.0,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    navigationBarTheme: navigatorBarThemeData,
  );

  static final darkThemeData = ThemeData(
    useMaterial3: true,
    primarySwatch: generateMaterialColor(Colors.white),
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    navigationBarTheme: navigatorBarThemeData,
  );
}
