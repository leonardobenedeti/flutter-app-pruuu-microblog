import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

enum ThemeType { light, dark }

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  ThemeType currentThemeType = ThemeType.dark;

  @computed
  ThemeData get currentThemeData =>
      (currentThemeType == ThemeType.light) ? _lightTheme : _darkTheme;

  @computed
  String get themeString =>
      (currentThemeType == ThemeType.light) ? 'Light' : 'Dark';

  @computed
  bool get isDark => currentThemeType == ThemeType.dark;

  @action
  void changeCurrentTheme() {
    currentThemeType =
        currentThemeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
    changeStatusBar();
  }

  @action
  void changeStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: currentThemeType == ThemeType.light
            ? Brightness.light
            : Brightness.dark));
  }

  final ThemeData _lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    cardColor: Colors.white, // Color bubble
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      // Tab Selected
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // Tab Unselected
      displayMedium: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // pruuu displayName
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      // pruuu userName and timestamp
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),

      // pruuu content
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),

      // Body text reverso em relação ao 1
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: .5, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: .8, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    cardColor: Colors.grey[800], // background danger button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      // Tab Selected
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // Tab Unselected
      displayMedium: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // pruuu displayName and trending title
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      // pruuu userName
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),

      // pruuu content
      bodyLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),

      // Body text reverso em relação ao 1
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(width: .5, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: .8, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
