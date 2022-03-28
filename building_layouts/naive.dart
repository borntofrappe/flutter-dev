import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  static String text =
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
              const ImageSection(),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: Column(
                  children: [
                    const TitleSection(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const ButtonsSection(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextSection(
                      text: text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 256,
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/lake.jpg',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  static String title = 'Oeschinen Lake Campground';
  static String location = 'Kandersteg, Switzerland';
  static int stars = 41;

  const TitleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Icon(
          Icons.star,
          size: 28.0,
          color: Colors.red[400],
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          '$stars',
        )
      ],
    );
  }
}

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          ColumnButton(
            icon: Icons.call,
            text: 'Call',
          ),
          ColumnButton(
            icon: Icons.near_me,
            text: 'Route',
          ),
          ColumnButton(
            icon: Icons.share,
            text: 'Share',
          ),
        ],
      ),
    );
  }
}

class ColumnButton extends StatelessWidget {
  final String text;
  final IconData icon;

  const ColumnButton({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
          color: Colors.blue[500],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.blue[500],
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  final String text;
  const TextSection({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
    );
  }
}
