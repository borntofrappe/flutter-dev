# startup_name_generator

## [Write your first Flutter app, part 1](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1)

### Starter Flutter app

Copy-paste to `lib/main.dart`.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

- create a material app, following the [Material visual-design language](https://material.io/design/)

- extend `StateLessWidget` to create a widget

  Everything in Flutter is a widget: `Scaffold`, `AppBar`, `Center`.

- use `Scaffold` to add an application bar, a title and a body

- use the `build` method to return the widget tree

- use `Center` to center the content in the screen

### Use an external package

Install [`english_words`](https://pub.dev/packages/english_words) from [pub.dev](https://pub.dev/), the package manager for Dart and Flutter apps.

In the console:

```bash
flutter pub add english_words
```

_Alternatively_ update `pubspec.yaml` and the `dependencies` field:

```yaml
dependencies:
  flutter:
    sdk: flutter
  english_words: ^4.0.0
```

Import the package in `main.dart`.

```dart
import 'package:english_words/english_words.dart';
```

In the `build` method initialize a pair

```dart
final wordPair = WordPair.random();
```

Instead of the string ìHello World' include the pair in a specific case

```diff
-child: Text('Hello World'),
+child: Text(wordPair.asPascalCase),
```

Remove `const` from the `Center` widget since the value is computed and the const constructor would require a known parameter.

```diff
const Center(
-Center(
```

### Add a stateful widget

Stateless: all values are final.

Stateful: might change during the lifetime of the widget.

The boilerplate for a stateful widget creates two classes.

```dart
class RandomWords extends StatefulWidget {
  const RandomWords({ Key? key }) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
```

The stateful widget `RandomWords` creates an instance of a state class `_RandomWordState`.

The app logic resides in `_RandomWordsState`.

The name of the state class is prefixed with an underscore as a matter of [privacy](https://dart.dev/guides/language/language-tour#libraries-and-visibility).

In place of the `Container` widget return a `Text` widget with a word pair.

```dart
final wordPair = WordPair.random();
return Text(wordPair.asPascalCase);
```

Remove the word pair in the stateless widget and replace the child with the new widget.

```diff
-child: Text(wordPair.asPascalCase),
+child: RandomWords(),
```

Add `const` back to the `Center` widget.

```diff
body: Center(
+body: const Center(
```

Also delete the line initializing the word pair in the `build` function as it becomes unnecessary.

```diff
Widget build(BuildContext context) {
-    final wordPair = WordPair.random();
```

### Create an infinite scrolling ListView

The stateless widget includes the widget tree from the stateful widget.

```dart
home: RandomWords(),
```

Through the stateful widget return a `Scaffold` describing the application bar.

```dart
return Scaffold(
  appBar: AppBar(
    title: const Text('Startup Name Generator'),
  ),
)
```

For the app body refer to a function defined in the same class.

```dart
return Scaffold(
  body: _buildSuggestions()
)
```

For the suggestions define a variable to keep track of the word pairs.

```dart
final _suggestions = <WordPair>[];
```

A list of `WordPair` instances.

The goal is to ultimately populate the collection in the body of the function responsible for the list.

Define the function returning the widget tree.

```dart
Widget _buildSuggestions() {}
```

Use the `ListView.builder` widget, specifically the `itemBuilder` field to produce one widget for each item in the list.

```dart
return ListView.builder(
  itemBuilder: (context, i) {
    // ..
  }
);
```

The function receives the building context and the index associated with the list items. In the body the goal is to access the individual items by index, `suggestions[index]`, and return a widget.

For every other item add a `Divider` widget so to separate successive word pairs. The widget adds a line spanning the width of the screen.

```dart
if(i.isOdd) {
  return const Divider();
}
```

Past this checkup return a `ListTile` widget for a word pair. The widget creates a tile, a panel with the text from the `title` field.

```dart
return ListTile(
  title: Text(
    _suggestions[index].asPascalCase
  ),
)
```

For the index compute the value from the input `i`, so as to accommodate for the divider.

```dart
final index = i ~/ 2;
```

Also use the value to add additional word pairs. The moment the index exceeds the number of items in the list add more pairs to continue past the existing entries.

```dart
if(index >= _suggestions.length) {
  _suggestions.addAll(generateWordPairs().take(10));
}
```

As a matter of preference the `ListTile` widget is refactored into its own function. This is to ultimately create the structure by receiving a pair.

```dart
Widget _buildRow(WordPair pair) {
  return ListTile(
    title: Text(
      pair.asPascalCase
    ),
  );
}
```

## [Write your first Flutter app, part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2)

### Add icons to the list

In the class extending the state, past the list of suggestions, define a set to keep track of saved word pairs.

```dart
final _saved = <WordPair>{};
```

In `_buildRow`, the function responsible for the widget tree of an individual pair, consider whether or not the pair is included in the set.

```dart
Widget _buildRow(WordPair pair) {
  final alreadySaved = _saved.contains(pair);
}
```

In ListTile add the `trailing` field to add an icon widget at the end of the tile.

```dart
ListTile(
  title: Text(),
  trailing: Icon(),
)
```

Use the boolean to change the design of the icon.

```dart
trailing: Icon(
  alreadySaved ? Icons.favorite : Icons.favorite_border,
  color: alreadySaved ? Colors.red : null,
  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
),
```

If the word pair is included in the set `alreadySaved` resolves to `true`. In this instance include a solid, red icon and the label 'Removed from saved'. Otherwise show the outline of the same icon with the label 'Save'.

### Add interactivity

Add an `onTap` field to the `ListTile` widget. The field describes a function which is called as the tile is tapped.

```dart
ListTile(
  title: Text(),
  trailing: Icon(),
  onTap: () {}
)
```

The idea is to add or remove the specific pair considering the boolean `alreadySaved`.

```dart
if(alreadySaved) {
  _saved.remove(pair);
} else {
  _saved.add(pair);
}
```

To have the change reflected in the application update the set in an anonymous function nested in `setState`.

```dart
setState(() {
  if(alreadySaved) {
    _saved.remove(pair);
  } else {
    _saved.add(pair);
  }
});
```

Every time you call `setState` Flutter calls the `build` function of the stateful widget.

### Navigate to a new screen

The goal is to show a list of only the word pairs stored in the `_saved` set in a separate screen.

The `Navigator` manages a stack of routes. You push a route onto the navigator to display a different screen. You pop the route to return to the previous page.

Add an `actions` field to the `AppBar` widget.

```dart
appBar: AppBar(
  title: const Text(),
  actions: []
)
```

The field receives a list of widgets which are rendered to the right of the bar's title.

In the list add a button widget with a specific icon and a tooltip, a label shown as the icon is pressed for a brief amount of time.

```dart
actions: [
  IconButton(
    icon: const Icon(Icons.list),
    tooltip: 'Saved Suggestions',
    onPressed: () {},
  )
]
```

With the `onPressed` field describe the functionality of the widget as the button is selected.

```dart
IconButton(
  icon: const Icon(),
  tooltip: '',
  onPressed: () {},
)
```

The course extracts the logic in a separate function, but it would be possible to include the instruction directly between curly braces.

```dart
onPressed: _pushSaved,
```

In the function call `Navigator.of(context).push`.

```dart
void _pushSaved() {
  Navigator.of(context).push(

  );
}
```

`context` is how a widget knows its location.

In the `push` function use `MaterialPageRoute` and its `builder` field to produce the widget tree for the new page.

```dart
Navigator.of(context).push(
  MaterialPageRoute<void>(
    builder: (context) {}
  )
);
```

The function receives the context and returns the widget(s) for the new page.

Return a `Scaffold` widget with an application bar and a `ListView` widget.

```dart
builder: (context) {

  return Scaffold(
    appBar: AppBar(),
    body: ListView()
  )
}
```

The structure is similar to the widget tree of the main route.

For the list view add a `children` field to include a list of widgets.

```dart
body: ListView(
  children: []
)
```

The idea is to replicate the tree of the main route, with word pairs in `ListTile` widgets separated by `Divider` widgets.

Loop through the `_saved` set to create the tiles.

```dart
final tiles = _saved.map(
  (pair) {
    return ListTile(
      title: Text(pair.asPascalCase)
    )
  }
)
```

Create the children list, named `divided` out of preference, to separate multiple tiles with the divider.

```dart
final divided = tiles.isNotEmpty
  ? // add divider
  : <Widget>[]
```

If the collection is empty `divided` is an empty list and the screen does not include a single tile.

If the collection is not empty the course adds a divider with a helper method `divideTiles`.

```dart
ListTile.divideTiles(
  context: context,
  tiles: tiles,
).toList()
```

The application is functionally complete.

As you tap the list icon `Navigator` pushes the new page on top of the existing screen. The application bar automatically adds a button to move back to the previous route.

### Change the UI using themes

Updatethe instance of `MaterialApp` through the `theme` field to change the overall look of the application.

```dart
return MaterialApp(
  theme: ThemeData()
)
```

The course instructs to move the `const` constructor from `MaterialApp` to the `home` field.

```diff
return const MaterialApp(
-return MaterialApp(

home: RandomWords()
+home: const RandomWords()
```

For the appearance use the `ThemeData` widget to modify the default values, set by the emulator, for instance for the application bar.

```dart
ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black
  )
)
```

The `AppBarTheme` changes the default background and foreground color.
