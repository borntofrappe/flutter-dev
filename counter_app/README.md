# counter_app

[flutter.dev/learn](https://flutter.dev/learn) introduces the development kit with a series of images, among which you find a prompt to create a flutter application and create a counter application.

![Counter app](https://storage.googleapis.com/cms-storage-bucket/740d82517a6f13db51bd.png)

The goal of this project is to create a similar application, focusing on the layout, appearance and persisting state.

## count

The first step is making a working counter app, without focusing much on the style and animation of the final result.

Create a stateful widget and a counter variable.

```dart
class _CounterState extends State<Counter> {
  int count = 0;
}
```

Update the variable through `setState`.

```dart
setState(() {
    count += 1;
});
```

Include the value in a `Text` widget.

```dart
Text('$count'),
```

## Layout

### Widget tree

## Design

### Custom font(s)

### Gradient

## Animation
