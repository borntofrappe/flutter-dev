# adding_interactivity

[The tutorial](https://docs.flutter.dev/development/ui/interactive) follows on the footsteps of [building layouts](https://docs.flutter.dev/development/ui/layout/tutorial), a separate tutorial devoted to creating the layout after a given screenshot. To this end `main.dart` is copy-pasted from the cited directory. The project also includes `lake.jpg` in the `images` folder.

The idea is to have the application interactive in the form of a custom widget for the number of times the page has been favorited. Tap the star icon to add or remove the location from the favorites, and in so doing modify the appearance of the icon and the accompanying counter.

## Stateful and stateless widgets

Stateful are those widgets which change over time — consider a text field. Stateless are does which never change — consider an icon.

The state of the widget is stored in a `State` object. You then change the state through the `setState()` function.

## Creating a stateful widget

In the example `FavoriteWidget` will manage its own state, given the isolated purpose of the widget — the only change occurs in the widget itself.

For a stateful widget you need to instantiate two classes extending `StatefullWidget` and `State`.

Create a subclass of `StatefullWidget`.

```dart
class FavoriteWidget extends StatefulWidget {
    const FavoriteWidget({Key? key}) : super(key: key);

    @override
    _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
```

The `createState` function creates an instance of `_FavoriteWidgetState`.

Create a subclass of `State`.

```dart
class _FavoriteWidgetState extends State<FavoriteWidget> {

    @override
    Widget build(BuildContext context) {
        return Container();
    }
}
```

### Add state

In the class extending the state define the necessary variables, for instance a boolean and an integer to keep track of the favorite state.

```dart
bool _isFavorited = true;
int _favoriteCount = 41;
```

In the `build` function return a widget tree exactly like in the instance of the material app.

In the specific tutorial create the following tree structure.

```text
Row
    Container
        IconButton
    SizedBox
        Text
```

The container helps to remove padding around the button, while the sized box ensures the text has a minimum width.

```dart
SizedBox(
    width: 18,
    child: Text()
)
```

For the button add an `onPressed` field to point to a callback function — defined later.

```dart
onPressed: _toggleFavorite()
```

For the state include the count in the text field.

```dart
Text('$_favoriteCount')
```

Use the boolean to conditionally use the filled or outlined version of the star icon.

```dart
icon: _isFavorited ? const Icon(Icons.star) : const Icon(Icons.star_border)
```

### Update state

Define the `_toggleFavorite` function to manage the state with `setState()`.

```dart
void _toggleFavorite() {
    setState(() {
        // ..
    });
}
```

The function explicitly tells Flutter to redraw the widget. so that the counter and the icon change as the button is pressed.

In the specific demo use the boolean's value to update the favorited state.

```dart
setState(() {
    if(_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
    } else {
        _favoriteCount += 1;
        _isFavorited = true;
    }
});
```

### Add widget

The last step is including the widget in the material application, specifically replacing the icon and hard-coded count value.

```diff
-Icon(Icons.star, color: Colors .red[500]),
-const Text('41')
+const FavoriteWidget()
```

Notice how the application includes the subclass of the stateful widget, not the subclass of the state.

## Managing state

The tutorial explains three different strategies to manage state. In the `lib` folder you find the code for each strategies. Test the result from `main.dart` by referencing the classes in the `runApp` function.

```dart
void main() {
    runApp(const ChildState());
    // runApp(const ParentState());
    // runApp(const MixState());
}
```

Each demo has the same `Container` widget which changes in color as the widget is pressed. To achieve the feat the code uses a `GestureDetector` widget.

Wrap the container in the specific widget.

```dart
GestureDetector(
    child: Container()
)
```

Add the `onTap` field to reference the function updating the state.

```dart
GestureDetector(
    onTap: handleTap,
)
```

_Please note:_ the actual name of the function might change in the different demos.

### Child state

The child widget is the stateful widget, managing the variable and the function updating its value.

```dart
class _TapBoxState extends State<TapBox> {
    bool _active = true;

    void _handleTap() {
        setState(() {
        _active = !_active;
        });
    }
}
```

### Parent state

The parent class is the stateful widget.

```dart
class _ParentStateState extends State<ParentState> {
  bool _active = true;

  void _toggleActive() {
    setState(() {
      _active = !_active;
    });
  }
}
```

In the widget tree create the child widget passing the necessary logic.

```dart
child: TapBox(active: _active, onChanged: _toggleActive)
```

Create the child widget as a stateless widget receiving the boolean and function.

```dart
class TapBox extends StatelessWidget {
    final bool active;
    final Function onChanged;

    const TapBox({
        Key? key,
        required this.active,
        required this.onChanged
    }) : super(key: key);
}
```

### Mix state

The parent and child class are both stateful widgets, with the goal of managing different parts of the child's state:

- the parent widget manages the active/inactive state

- the child widget manages the highlight state

In this instance the child widget defines the variables both subclasses.

In the subclass of `StatefulWidget`, to receive the values from the parent.

```dart
class TapBox extends StatefulWidget {
    final bool active;
    final Function onChanged;

    // const TapBox(...)
}
```

In the subclass of `State`, to define its own logic.

```dart
class _TapBoxState extends State<TapBox> {
    bool _highlight = false;
}
```

Notice that in this instance you access the logic inherited from the parent through the `widget` object.

```diff
-child: Text(active ? 'Active' : 'Inactive')
+child: Text(widget.active ? 'Active' : 'Inactive')
```
