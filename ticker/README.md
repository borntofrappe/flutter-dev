# ticker

[counter_app](https://github.com/borntofrappe/flutter-dev/tree/master/counter_app) creates a counter application focusing on a given layout. The goal of this project is to approach the feature with a different perspective, focusing on the animation of the digits as the count is updated.

## ListWheelScrollView

Use `ListWheelScrollView` to show digits in the [0-9] range one above the other. The widget requires two fields: `itemExtent` and `children`. In this last property create a list of widget to show the ten numbers.

```dart
List<Widget>.generate(digits, (index) => FittedBox(child: Text(('$index'))))
```

## Control

The goal is to ultimately handle the scrolling through two buttons instead of the wheel.

Disable the wheel's scrolling with `physics`.

```dart
ListWheelScrollView(
    physics: const NeverScrollableScrollPhysics(),
)
```

Make the widget into a stateful widget to manage state.

```dart
class Ticker extends StatefulWidget {
}
class _TickerState extends State<Ticker> {
}
```

Define a controller in the subclass of state.

```dart
final FixedExtentScrollController _controller = FixedExtentScrollController();
```

Dispose of the resources allocated to the controller through the lifecycle method.

```dart
@override
void dispose() {
  super.dispose();

  _controller.dispose();
}
```

Include the controller in the wheel.

```dart
ListWheelScrollView(
    controller: _controller,
)
```

Include two buttons to scroll up and down. With `onPressed` invoke a separate function.

```dart
onPressed: () => _scroll(-1),
onPressed: () => _scroll(1),
```

Define `_scroll` to update the wheel through the controller.

```dart
void _scroll(int direction) {
}
```

Retrieve the current value with `_controller.selectedItem` and change it according to the input direction.

```dart
void _scroll(int direction) {
_controller.animateToItem(_controller.selectedItem + 1 * direction,
}
```

Add the required duration and curve.

```dart
_controller.animateToItem(
    VALUE,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeInOutSine
);
```

## Infinite scroll

Connected to the list wheel widget you find `ListWheelScrollView.useDelegate` to generate the children programmatically. In the required `childDelegate` field you can use the `ListWheelChildLoopingListDelegate` widget to create an closed wheel, or rather a repeating wheel with the input digits.

```dart
ListWheelScrollView.useDelegate(
    childDelegate: ListWheelChildLoopingListDelegate(
        children: _children
    )
)
```

Ultimately, however, I chose not to pursue the looping route. This is more as a matter of preference in terms of the values assumed by the controller in `_controller.selectedItem`, which I'd rather keep in a given range instead of extending to large positive _or_ negative numbers.

Keeping the existing `ListWheelScrollView` widget create a list with one more number than necessary.

```diff
 List<Widget>.generate(digits, )
+List<Widget>.generate(digits + 1,)
```

Remove the excess in the text widget.

```dart
Text((index % digits).toString())
```

In the scrolling function directly update the current item directly in the two instances when the selected item falls outside of the list.

```dart
if(direction == -1 && _controller.selectedItem == 0) {
    _controller.jumpToItem(digits);
} else if(direction == 1 && _controller.selectedItem == digits) {
    _controller.jumpToItem(0);
}
```

The illusion works since you jump to the item before you animate the wheel and ultimately hide all numbers except the one displayed in the center with `overAndUnderCenterOpacity`.

```dart
overAndUnderCenterOpacity: 0.0,
```

## Multiple wheels

The idea is to ultimately implement a counting feature with exceed the unit column.

Define the number of columns — at first with a constant.

```dart
const columns = 3;
```

In the stateful widget create a list of controllers instead of a single instance of `FixedExtentScrollController`.

```dart
final List<FixedExtentScrollController> _controllers =
      List<FixedExtentScrollController>.generate(
          columns, (_) => FixedExtentScrollController());
```

Dispose of all controllers in the matching lifecycle method.

```dart
for (FixedExtentScrollController _controller in _controllers) {
    _controller.dispose();
}
```

In the widget tree loop through the controllers to add one wheel for each column. In terms of widget tree add `ListWheelScrollView` in an `Expanded` widget. Wrap the expanded widgets in a row to have the wheels side by side.

```text
Row
    Expanded
        ListWheelScrollView
    Expanded
        ListWheelScrollView
```

In the `controller` field add the respective controller, from the looping function.

```dart
_controllers.map(
    (_controller) => Expanded(
        child: ListWheelScrollView(
            controller: _controller,
        )
    )
).toList()
```

In the `children` field generate a list for each wheel instead of relying on the one created ahead of time.

```dart
children: List<Widget>.generate(digits + 1,)
```

Using a single list does not seem to cause issues, at least with a cursory look, but it is reasonable to create a set for each separate wheel.

## Update counter

With multiple columns you need to consider when a digit exceeds the [0-9] range, in either direction.

The idea is to update the `scroll` function to immediately modify the last column, then move backwards if necessary.

Initialize a counter variable to start at the end of the controllers' list.

```dart
int index = _controllers.length;
```

In a `do..while` loop decrement the counter variable — which explains why the initial value is actually off by one.

```dart
do {
    index -= 1;

} while(index > 0)
```

If you were to modify all columns you'd execute the previous logic for every single controller.

```dart
do {
    index -= 1;
    // _controllers[index]

} while(index > 0)
```

To consider only the [0-9] extremes, update the `while` condition considering the selected item and direction.

```dart
while (
    index > 0 &&
    (
    (direction == 1 && _controllers[index].selectedItem == digits - 1)
    ||
    (direction == -1 && _controllers[index].selectedItem == digits)
    )
)
```

In the body of the repeating block log the selected item to double check the value.

---

## Going further

You can expand the application <!-- especially as you learn more about flutter --> in several ways, but as a first step consider adding a settings page to customize the application. Allow to change the number of digits, or again to tweak the animation, or again to avoid persisting state and start from zero every time the app is launched.
