import 'package:flutter/material.dart';

import 'package:material_design/home.dart';
import 'package:material_design/login.dart';

import 'package:material_design/colors.dart';

import 'package:material_design/supplemental/cut_corners_border.dart';

import 'package:material_design/backdrop.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
      secondary: kShrineBrown900,
      error: kShrineErrorRed,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: CutCornersBorder(
          borderSide: BorderSide(width: 2.0, color: kShrineBrown900)),
      border: CutCornersBorder(),
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: kShrinePink100),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    if (settings.name != '/login') return null;

    return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => const LoginPage(),
        fullscreenDialog: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      theme: _kShrineTheme,
      home: Backdrop(
        backLayer: Container(color: kShrinePink100),
        frontLayer: HomePage(),
        backTitle: const Text('MENU'),
        frontTitle: const Text('SHRINE'),
      ),
      initialRoute: '/login',
      onGenerateRoute: _generateRoute,
    );
  }
}
