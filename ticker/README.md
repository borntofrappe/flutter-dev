# ticker

![](https://github.com/borntofrappe/flutter-dev/blob/master/ticker/ticker.jpg)

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

## Scroll order

As a matter of preference the application counts numbers by having larger values above smaller ones. One way to achieve the feat is to:

1.  reverse the list of widget describing the numbers

    ```dart
    List<Widget>.generate().reversed.toList()
    ```

2.  update the buttons to scroll the numbers in the new direction

    ```dart
    onPressed: () => _scroll(1) // remove
    onPressed: () => _scroll(-1) // add
    ```

3.  reconsider the condition in the `while` statement since the order of the numbers is flipped

## Initial count

In the moment the application stores the count value locally — see the next section — it is helpful to have the stateful widget receive a value for the initial count.

```dart
Ticker(count: 109)
```

As a matter of preference initialize the variable to have the argument optional.

```dart
class Ticker extends StatefulWidget {
  final int count;
  const Ticker({Key? key, this.count = 0}) : super(key: key);
}
```

In the subclass of state update the columns through the controllers. Since the logic relies on the `ListWheelScrollView` widgets actually existing include the instructions in the `initState` lifecycle _and_ a function run as the widget is built.

```dart
@override
void initState() {
super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
        // update controllers
    });
}
```

Note that the order of the numbers in the lists is reversed, so you need to map the individual digits to the corresponding index.

Once you extract the number for each column in a variable `digit`:

- update the controllers to jump at the bottom of the wheel.

  ```dart
  _controllers[index].jumpToItem(digits);
  ```

- animate the controllers back to the correct item.

  ```dart
  _controllers[index].animateToItem(
      digits - digit,
      // ...
  )
  ```

## App structure

Before considering how to persist data as the app is closed — see to the next section — it is helpful to restructure the application.

Have the `main` function invoke `MyApp`, a stateful widget. Stateful since the widget will handle the logic for the initial count.

```dart
void main() {
  runApp(const MyApp());
}
```

Use `MyApp` to return an instance of `MaterialApp`, the `Scaffold` widget and eventually `Ticker`.

```text
MaterialApp
    Scaffold
        Ticker
```

With `Ticker` preserve the controller logic, but modify the `build` function to return the `Column` widget and anything which follows.

## Persisting state

Add `shared_preferences` to the config file.

```yaml
dependencies:
  flutter:

  shared_preferences: ^2.0.13
```

Import the dependency in `main.dart`.

```dart
import 'package:shared_preferences/shared_preferences.dart';
```

### Retrieve data

In the stateful widget `MyApp` initialize a variable for the initial count.

```dart
int _count = 0;
```

In the body of the `initState` function call a function to update the variable.

```dart
@override
void initState() {
  super.initState();

  _getCount();
}
```

Update the count through an instance of `SharedPreferences`.

```dart
void _getCount() async {
  final instance = await SharedPreferences.getInstance();
  setState(() {
    _count = instance.getInt('count') ?? 0;
  });
}
```

Send the value to the `Ticker` widget.

```dart
Ticker(count: _count)
```

### Scroll to count

In previous versions `Ticker` was able to set the initial count through `initState`, but using the value from the parent widget would not work to show the saved number.

```dart
@override
void initState() {
    super.initState();

    _scrollToCount(widget.count);
}
```

This is because `initState` is called once, as the widget is created, and with a value of `0`. Eventually `widget.count` is updated, but the lifecycle method is not repeat.

To this end you need to consider the number in the `build` function.

```dart
@override
Widget build(BuildContext context) {
    _scrollToCount(widget.count);
}
```

### Save data

In the stateful widget `MyApp` define a function to save an input number with shared preferences.

```dart
void _setCount(int count) async {
  final instance = await SharedPreferences.getInstance();
  instance.setInt('count', count);
}
```

Send the function to the `Ticker` widget alongside the counter variable.

```dart
Ticker(
    count: _count,
    onChange: _setCount
)
```

Update the widget to set the function among its properties.

```dart
class Ticker extends StatefulWidget {
    final Function onChange;
    const Ticker({
        required this.onChange
        // ..
    });
}
```

It is reasonable to save the data as one of the buttons is pressed and the digits scroll. In the `_scroll` function use a `Future` to wait for the animation to end.

```dart
Future.delayed(const Duration(milliseconds: 250), () {
});
```

Compute the `count` looping through the controllers and adding up the unit, ten, hundred columns.

```dart
int count = 0;
for (int i = 0; i < _controllers.length; i++) {
    count += ((digits - _controllers[i].selectedItem) % digits) *
        pow(10, _controllers.length - i - 1).toInt();
}
```

You need to import the math library to use from the `pow` function.

```dart
import 'dart:math';
```

Call the function received as argument with the computed count.

```dart
widget.onChange(count);
```

## Final touches

Finally set the opacity to hide the digits except the relevant ones.

```diff
-overAndUnderCenterOpacity: 1.0,
+overAndUnderCenterOpacity: 0.0,
```

As a matter of preference update the widget tree to add padding, divide the space between the two section, change the default colors and add a custom font.

Also as a matter of preference stagger the animation for the initial count to have successive columns animated in sequence and with a snappier timing function.

## Going further

You can expand the application <!-- especially as you learn more about flutter --> in several ways, but as a first step consider adding a settings page to customize the application. Allow to change the number of digits, or again to tweak the animation, or again to avoid persisting state and start from zero every time the app is launched.
