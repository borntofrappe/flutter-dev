// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  static String description =
      'Lake Oeschinen lies at the foot of the Bluemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.';

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Building layouts',
        home: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Hero(),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(children: [
                  Header(),
                  SizedBox(height: 16.0),
                  Actions(),
                  SizedBox(height: 16.0),
                  Description(text: description)
                ]),
              )
            ],
          ),
        )));
  }
}

class Hero extends StatelessWidget {
  const Hero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 256),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/lake.jpg'), fit: BoxFit.fitWidth),
          ),
        ));
  }
}

class Header extends StatelessWidget {
  static String title = 'Oeschinen Lake Campground';
  static String location = 'Kandersteg, Switzerland';
  static int stars = 41;

  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text(location, style: const TextStyle(color: Colors.black45)),
        ]),
      ),
      SizedBox(width: 8.0),
      Icon(Icons.star, size: 28.0, color: Colors.red[400]),
      SizedBox(width: 8.0),
      Text('$stars')
    ]);
  }
}

class Actions extends StatelessWidget {
  const Actions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Action(icon: Icons.call, text: 'Call'),
        Action(icon: Icons.near_me, text: 'Route'),
        Action(icon: Icons.share, text: 'Share'),
      ]),
    );
  }
}

class Action extends StatelessWidget {
  final String text;
  final IconData icon;

  const Action({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 32, color: Colors.blue[500]),
      SizedBox(height: 8.0),
      Text(text.toUpperCase(), style: TextStyle(color: Colors.blue[500]))
    ]);
  }
}

class Description extends StatelessWidget {
  final String text;
  const Description({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
