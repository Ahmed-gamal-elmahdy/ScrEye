import 'package:flutter/material.dart';

enum ThemeMode {
  whiteTheme,
  darkTheme,
  monochromacyTheme,
}

class MyTheme {
  static ThemeData whiteTheme() {
    Color primary = const Color(0xFF225270);
    Color primaryVariant1 = const Color(0xFF3177A3);
    Color primaryVariant2 = const Color(0xFFC7E4FA);

    Color secondary = const Color(0xFFF05454);
    Color secondaryVariant1 = const Color(0xFFF05454);
    // Color secondaryVariant2 = const Color(0xFFFFFFFF);

    Color tertiary = const Color(0xFFFFFFFF);
    Color tertiaryVariant1 = const Color(0xFFFFFFFF);
    // Color tertiaryVariant2 = const Color(0xFFFFFFFF);

    return ThemeData(
      appBarTheme: AppBarTheme(
        foregroundColor: tertiary,
        backgroundColor: primaryVariant1,
        iconTheme: IconThemeData(
          color: secondary,
        ),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: primary),
        headline6: TextStyle(color: primary),
        headline3: TextStyle(color: tertiary),
        headline2: TextStyle(color: primary),
        headline1: TextStyle(color: primary),
        headline5: TextStyle(color: secondary),
        subtitle1: TextStyle(color: primaryVariant1),
        subtitle2: TextStyle(color: secondaryVariant1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryVariant1,
        unselectedItemColor: tertiary,
        selectedItemColor: secondary,
      ),
      canvasColor: tertiary,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary, // Text Color
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          foregroundColor: MaterialStateProperty.all<Color>(primary),
          backgroundColor: MaterialStateProperty.all<Color>(primaryVariant2),
          shadowColor: MaterialStateProperty.all<Color>(tertiary),
          side: MaterialStateProperty.all(BorderSide(
            color: primary,
          )),
        ),
      ),
      drawerTheme: DrawerThemeData(
        scrimColor: Colors.blue.withOpacity(0.25),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: primaryVariant1,
        textColor: primaryVariant1,
        tileColor: primaryVariant2,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: secondary,
        textColor: primary,
        collapsedTextColor: primary,
        collapsedIconColor: primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(secondary),
      ),
      dividerTheme: DividerThemeData(
        color: primaryVariant2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: primary,
        ),
        hintStyle: TextStyle(
          color: primaryVariant1,
        ),
        floatingLabelStyle: TextStyle(color: secondary),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryVariant1),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryVariant2),
        ),
        suffixIconColor: secondary,
        iconColor: primaryVariant1,
      ),
    );
  }

  static ThemeData darkTheme() {
    Color primary = const Color(0xFF03DAC6);
    Color primaryVariant1 = const Color(0xFFFFFFFF);
    Color primaryVariant2 = const Color(0xFFFFFFFF);

    Color secondary = const Color(0xFF03DAC6);
    Color secondaryVariant1 = const Color(0xFFBB86FC);
    // Color secondaryVariant2 = const Color(0xFFFFFFFF);

    Color tertiary = const Color(0xFF121212);
    Color tertiaryVariant1 = const Color(0xFF202020);
    // Color tertiaryVariant2 = const Color(0xFFFFFFFF);

    return ThemeData(
      appBarTheme: AppBarTheme(
        foregroundColor: primaryVariant1,
        backgroundColor: tertiaryVariant1,
        iconTheme: IconThemeData(
          color: secondary,
        ),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: primaryVariant1),
        //
        headline6: TextStyle(color: primaryVariant1),
        //
        headline3: TextStyle(color: tertiary),
        headline2: TextStyle(color: tertiaryVariant1),
        headline1: TextStyle(color: primaryVariant1),
        //
        subtitle1: TextStyle(color: primaryVariant1),
        subtitle2: TextStyle(color: secondary),
        headline5: TextStyle(color: secondaryVariant1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: tertiaryVariant1,
        unselectedItemColor: secondary,
        selectedItemColor: secondaryVariant1,
      ),
      canvasColor: tertiary,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary, // Text Color
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          foregroundColor: MaterialStateProperty.all<Color>(primary),
          backgroundColor: MaterialStateProperty.all<Color>(tertiary),
          shadowColor: MaterialStateProperty.all<Color>(tertiary),
          side: MaterialStateProperty.all(BorderSide(
            color: primary,
          )),
        ),
      ),
      drawerTheme: DrawerThemeData(
        scrimColor: Colors.blue.withOpacity(0.25),
        backgroundColor: tertiary,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: primaryVariant1,
        textColor: primaryVariant1,
        tileColor: tertiaryVariant1,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: secondaryVariant1,
        textColor: primary,
        collapsedTextColor: primary,
        collapsedIconColor: primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(secondary),
      ),
      dividerTheme: DividerThemeData(
        color: primaryVariant2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: primaryVariant1,
        ),
        hintStyle: TextStyle(
          color: primaryVariant1,
        ),
        floatingLabelStyle: TextStyle(color: secondary),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryVariant1),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryVariant2),
        ),
        suffixIconColor: secondary,
        iconColor: primaryVariant1,
      ),
    );
  }

  static ThemeData monochromacyTheme() {
    Color primary = const Color(0xFF225270);
    Color primaryVariant1 = const Color(0xFF3177A3);
    Color primaryVariant2 = const Color(0xFFC7E4FA);

    Color secondary = const Color(0xFF946C13);
    Color secondaryVariant1 = const Color(0xFF946C13);
    // Color secondaryVariant2 = const Color(0xFFFFFFFF);

    Color tertiary = const Color(0xFFFFFFFF);
    Color tertiaryVariant1 = const Color(0xFFFFFFFF);
    // Color tertiaryVariant2 = const Color(0xFFFFFFFF);

    return ThemeData(
      appBarTheme: AppBarTheme(
        foregroundColor: tertiary,
        backgroundColor: primaryVariant1,
        iconTheme: IconThemeData(
          color: secondary,
        ),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: primary),
        headline6: TextStyle(color: primary),
        headline3: TextStyle(color: tertiaryVariant1),
        headline2: TextStyle(color: primary),
        headline1: TextStyle(color: primary),
        headline5: TextStyle(color: secondary),
        subtitle1: TextStyle(color: primaryVariant1),
        subtitle2: TextStyle(color: secondaryVariant1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryVariant1,
        unselectedItemColor: tertiary,
        selectedItemColor: secondary,
      ),
      canvasColor: tertiary,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary, // Text Color
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          foregroundColor: MaterialStateProperty.all<Color>(primary),
          backgroundColor: MaterialStateProperty.all<Color>(primaryVariant2),
          shadowColor: MaterialStateProperty.all<Color>(tertiary),
          side: MaterialStateProperty.all(BorderSide(
            color: primary,
          )),
        ),
      ),
      drawerTheme: DrawerThemeData(
        scrimColor: Colors.blue.withOpacity(0.25),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: primaryVariant1,
        textColor: primaryVariant1,
        tileColor: primaryVariant2,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: secondary,
        textColor: primary,
        collapsedTextColor: primary,
        collapsedIconColor: primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(secondary),
      ),
      dividerTheme: DividerThemeData(
        color: primaryVariant2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: primary,
        ),
        hintStyle: TextStyle(
          color: primaryVariant1,
        ),
        floatingLabelStyle: TextStyle(color: secondary),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryVariant1),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryVariant2),
        ),
        suffixIconColor: secondary,
        iconColor: primaryVariant1,
      ),
    );
  }

  static ThemeData getTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.darkTheme:
        return MyTheme.darkTheme();
      case ThemeMode.whiteTheme:
        return MyTheme.whiteTheme();
      case ThemeMode.monochromacyTheme:
        return MyTheme.monochromacyTheme();
      default:
        return MyTheme.whiteTheme();
    }
  }
}
