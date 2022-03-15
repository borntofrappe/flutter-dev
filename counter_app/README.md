# counter_app

[flutter.dev/learn](https://flutter.dev/learn) introduces the development kit with a series of images, among which you a picture depicting a counter application.

![Counter app](https://storage.googleapis.com/cms-storage-bucket/740d82517a6f13db51bd.png)

The goal of this project is to recreate the application focusing on the feature and the overall design.

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

## Design

### Layout

The application begins with a `MaterialApp` and `Scaffold` widgets. From this starting point wrap the content in a `SafeArea` to push the child below the space of the status bar.

Wrap `SafeArea` in a `Container` to include the gradient — explained in the next section.

Past `Padding` widgets to separate the content from the surrounding elements create the following widget tree.

```text
Column
  Text
  Expanded
    Center
      Text
  Row
    IconButton
    IconButton
```

Wrap the row in a `ConstrainedBox` widget to avoid having the buttons too further apart on larger screens.

Additionally, wrap each button in a `Container` widget to include the rounded border — explained in the next section.

### Style

Add a custom font through the yaml configuration file.

```yaml
fonts:
  - family: Ubuntu
    fonts:
      - asset: fonts/Ubuntu-Bold.ttf
```

Reference the family by the specified string.

```dart
TextStyle(
  fontFamily: 'Ubuntu'
)
```

In terms of color specify a particular hex value with the `0xff` prefix. `0x` works to describe hexadecimal notation, `ff` describes the opacity.

```dart
Color color = const Color(0xff043875);
```

For the gradient use the `LinearGradient` widget, specifying the hex colors in the appropriate field.

```dart
LinearGradient(
      colors: [Color(0xffc6bafa), Color(0xffefbad7)],
)
```

Use additional fields to customize the gradient as a matter of preference.

Include the widget in a `BoxDecoration` and in the `decoration` property of a generic `Container`.

```dart
decoration: BoxDecoration(
  gradient: LinearGradient
)
```

Rounded borders follow a similar pattern. Add a `Container`, a `decoration` field and a `BoxDecoration` widget. In this instance, however, point to the border property instead of the gradient.

```dart
decoration: BoxDecoration(
  border: Border.all(color: color, width: 4.0)
)
```

For rounded corners add an additional widget as `borderRadius`.

```dart
BoxDecoration(
  borderRadius: BorderRadius.circular(50)
)
```
