import 'package:flutter/material.dart';
import 'package:adding_interactivity/childState.dart';
import 'package:adding_interactivity/parentState.dart';
import 'package:adding_interactivity/mixState.dart';

void main() {
  // runApp(const ChildState());
  // runApp(const ParentState());
  // runApp(const MixState());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32.0),
        child: Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: const Text('Oeschinen Lake Campground',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Text('Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]))
            ]),
          ),
          const FavoriteWidget()
        ]));

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Text(label,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: color)))
          ]);
    }

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection =
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _buildButtonColumn(color, Icons.call, 'CALL'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE')
    ]);

    Widget textSection = const Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true,
        ));

    return MaterialApp(
        title: 'Building layouts',
        home: Scaffold(
          appBar: AppBar(title: const Text('Building layouts')),
          body: ListView(children: [
            Image.asset('images/lake.jpg',
                width: 600, height: 240, fit: BoxFit.cover),
            titleSection,
            buttonSection,
            textSection
          ]),
        ));
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.all(0),
            child: IconButton(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                icon: _isFavorited
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
                color: Colors.red[500],
                onPressed: _toggleFavorite)),
        SizedBox(width: 18.0, child: Text('$_favoriteCount'))
      ],
    );
  }
}
