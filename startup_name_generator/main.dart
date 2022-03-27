import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      title: 'Startup Name Generator',
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        setState(
          () {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          },
        );
      },
    );
  }

  void _pushSaved() {
    final tiles = _saved.map((pair) {
      return ListTile(title: Text(pair.asPascalCase));
    });

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
        : <Widget>[];

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
