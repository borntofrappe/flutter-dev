# counter

[flutter.dev/learn](https://flutter.dev/learn) introduces the development kit with a series of images, among which you a picture depicting a counter application.

![Counter app](https://storage.googleapis.com/cms-storage-bucket/740d82517a6f13db51bd.png)

The goal of this project is to recreate the application focusing on the feature first and the overall design second.

## counter

The first step is creating a stateful widget, keeping track of a counter variable.

```dart
class _CounterState extends State<Counter> {
  int _counter = 0;
}
```

Update the count with a button, invoking a function which updates the variable through `setState`.

```dart
void _updateCounter(int change) {
  setState(() {
    _counter += change;
  });
}
```

Call the function in the button widgets.

```dart
onPressed: () => _updateCounter(1)
```

Use the value in a text widget.

```dart
Text('Value: $_counter')
```

As a first, rudimentary structure create the following widget tree.

```text
Column
  Text
  IconButton
  IconButton
```
