import 'package:delivery_backoffice_dw10/src/core/ui/styles/app_styles.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/colors_app.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _DefaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey[400]!));
  static final theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.instance.primary,
        primary: ColorsApp.instance.primary,
        secondary: ColorsApp.instance.secondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppStyles.instance.primaryButton,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.all(20),
        border: _DefaultInputBorder,
        enabledBorder: _DefaultInputBorder,
        focusedBorder: _DefaultInputBorder,
        labelStyle:
            TextStyles.instance.textRegular.copyWith(color: Colors.black),
        errorStyle:
            TextStyles.instance.textRegular.copyWith(color: Colors.redAccent),
      ));
}
