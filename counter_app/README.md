# counter_app

[flutter.dev/learn](https://flutter.dev/learn) introduces the development kit with a series of images, among which you find a prompt to create a flutter application and create a counter application.

![Counter app](https://storage.googleapis.com/cms-storage-bucket/740d82517a6f13db51bd.png)

The goal of this project is to immediately recreate the layout, but then try and develop a more elaborate application in which the numbers scroll vertically.

## Counter

The first step is creating a stateful widget, keeping track of a counter variable.

```dart
class _CounterState extends State<Counter> {
  int _counter = 0;
}
```

Update the count with a button, invoking a function which updates the variable through `setState`.

```dart
void _updateCounter(int delta) {
  setState(() {
    _counter += delta;
  });
}
```

Call the function in the button widgets.

```dart
onPressed: () => _updateCounter(1)
```

Use the value in a text widget.

```dart
Text('$_counter')
```

## Shared preferences

Install `shared-preferences` with the ultimate goal of saving the value locally in a key-value pair.

```yaml
dependencies:
  shared_preferences: ^2.0.13
```

Define two functions to 1. retrieve the stored value and 2. update the counter _and_ the stored value.

### Get counter

Define a `_getCounter` function.

```dart
void _getCounter() {
}
```

To retrieve the value retrieve the preference from the `SharedPreferences` object.

```dart
final instance = await SharedPreferences.getInstance();
```

Remember to import the module

```dart
import 'package:shared_preferences/shared_preferences.dart';
```

Remember to make the function asynchronous.

```dart
void _getCounter() async {
}
```

Retrieve the counter with the `getInt` method.

```dart
_counter = prefs.getInt('counter')
```

With the `??` operator provide a default value if there is no matching key.

```dart
_counter = instance.getInt('counter') ?? 0;
```

Since you need to update the widget tree include the call in `setState`.

```dart
setState(() {
  _counter = instance.getInt('counter') ?? 0;
});
```

Invoke the get function through `initState` to update the counter as the widget is mounted.

```dart
void _getCounter() {
  super.initState();

  _getCounter();
}
```

### Update counter

Modify the logic of `_updateCounter` so that you update not only the `_counter` variable, but also the number in the shared preferences.

As with the get function update the definition to have the function asynchronous.

```dart
void _updateCounter(int delta) async {
}
```

Create an instance of shared preferences.

```dart
final instance = await SharedPreferences.getInstance();
```

In the body of `setState` update the counter incrementing the stored value.

```dart
_counter = (instance.getInt('counter') ?? 0) + delta;
```

Store the new value.

```dart
instance.setInt('counter', _counter);
```
