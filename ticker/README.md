# ticker

[counter_app](https://github.com/borntofrappe/flutter-dev/tree/master/counter_app) creates a counter application focusing on a given layout. The goal of this project is to approach the feature with a different perspective, focusing on the animation of the digits as the count is updated.

## ListWheelScrollView

Use `ListWheelScrollView` to show digits in the [0-9] range one above the other. The widget requires two fields: `itemExtent` and `children`. In this last property create a list of widget to show the ten numbers.

```dart
List<Widget>.generate(digits, (index) => FittedBox(child: Text(('$index'))))
```

## List wheel properties

Disable physics-based scrolling with `physics`.

```dart
physics: const NeverScrollableScrollPhysics(),
```

Hide numbers except the one displayed in the center with `overAndUnderCenterOpacity`.

```dart
overAndUnderCenterOpacity: 0.0,
```

Customize the wheel further with `perspective` and `diameterRatio`.

## Going further

You can expand the application <!-- especially as you learn more about flutter --> in several ways, but as a first step consider adding a settings page to customize the application. Allow to change the number of digits, or again to tweak the animation, or again to avoid persisting state and start from zero every time the app is launched.
