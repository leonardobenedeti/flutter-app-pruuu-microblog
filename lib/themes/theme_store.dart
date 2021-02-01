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
    accentColor: Colors.black, // Loading color
    backgroundColor: Colors.transparent, // background danger button
    buttonColor: Colors.black87,
    errorColor: Colors.red[900],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      // Tab Selected
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // Tab Unselected
      headline2: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // pruuu displayName
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      // pruuu userName and timestamp
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),

      // pruuu content
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),

      // Body text reverso em relação ao 1
      bodyText2: TextStyle(
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
    cardColor: Colors.grey[800], // Color bubble
    accentColor: Colors.grey[50], // Loading color
    buttonColor: Colors.grey[50],
    errorColor: Colors.red[900],
    backgroundColor: Colors.white, // background danger button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      // Tab Selected
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // Tab Unselected
      headline2: TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      // pruuu displayName and trending title
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      // pruuu userName
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),

      // pruuu content
      bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),

      // Body text reverso em relação ao 1
      bodyText2: TextStyle(
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
