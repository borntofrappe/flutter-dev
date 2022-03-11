# counter_app

[flutter.dev/learn](https://flutter.dev/learn) introduces the development kit with a series of images, among which you find a prompt to create a flutter application and create a counter application.

![Counter app](https://storage.googleapis.com/cms-storage-bucket/740d82517a6f13db51bd.png)

The goal of this project is to create a similar application, focusing on the layout, appearance and persisting state.

## Counter

The first step is making a working counter app, without focusing much on the style and animation of the final result.

Create a stateful widget and a counter variable.

```dart
class _CounterState extends State<Counter> {
  int _counter = 0;
}
```

Update the variable through `setState`.

```dart
void _updateCounter(int increment) {
  setState(() {
      _counter += increment;
  });
}
```

Include the value in a `Text` widget.

```dart
Text('$_counter'),
```

## Persistent data

Using `shared_references` store the value of the counter locally with a key-value pair.

Install the module.

```yaml
dependencies:
  flutter:

  shared_preferences: ^2.0.13
```

When initializing the stateful widget call a function to retrieve the existing value — if existing.

```dart
@override
  void initState() {
  super.initState();

  _getCounter();
}
```

Define the function to retrieve the key and provide a default value of zero.

```dart
void _getCounter() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _counter = prefs.getInt('counter') ?? 0;
  });
}
```

When updating the counter variable increment the value directly from shared preferences.

```dart
void _updateCounter(int increment) {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _counter = (prefs.getInt('counter') ?? 0) + increment;
    prefs.setInt('counter', _counter);
  });
}
```

## Layout

```text
Column
  Text
  Expanded
    ConstrainedBox
      FittedBox
        Text
  Row
    Container
      IconButton
    Container
      IconButton
```
