import 'package:flutter/material.dart';

import 'package:material_design/home.dart';
import 'package:material_design/login.dart';

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
      home: const HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _generateRoute,
    );
  }
}
