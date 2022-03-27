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

The script:

- creates a material app, following the [Material visual-design language](https://material.io/design/)

- extends `StateLessWidget` to create a widget

  Everything in Flutter is a widget: `Scaffold`, `AppBar`, `Center`.

- uses `Scaffold` to add an application bar, a title and a body

- uses the `build` method to return the widget tree

- uses `Center` to center the content in the screen

### Use an external package

Install [`english_words`](https://pub.dev/packages/english_words) from [pub.dev](https://pub.dev/), the package manager for Dart and Flutter apps.

Update `pubspec.yaml` and the `dependencies` field:

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

In the `build` method initialize a pair.

```dart
final wordPair = WordPair.random();
```

Instead of the string "Hello World" include the pair with a specific case.

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

Stateless are those widgets whose all values are final.

Stateful are those widget whose values might change during the lifetime of the widget itself.

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

Describe the logic in the class extending `State`.

---

The name of the state class is prefixed with an underscore as a matter of [privacy](https://dart.dev/guides/language/language-tour#libraries-and-visibility).

---

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

In the stateless widget include the stateful widget in the `home` field of the material app instance.

```dart
home: RandomWords(),
```

In the stateful widget return a `Scaffold` describing the application bar.

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
);
```

For the suggestions define a variable to keep track of the word pairs before the `build` method.

```dart
final _suggestions = <WordPair>[];
```

`_suggestion` is a list of `WordPair` instances.

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


Call the function instead of returning the list tile widget.

```dart
return _buildRow(_suggestions[index]);
```

