# adding_interactivity

[The codelab](https://docs.flutter.dev/development/ui/interactive) follows on the footsteps of [building layouts](https://docs.flutter.dev/development/ui/layout/tutorial), a separate tutorial devoted to creating the layout after a given screenshot.

## Setup

I followed the codelab in a separate folder of this repository.

[From the separate folder](https://github.com/borntofrappe/flutter-dev/tree/master/building_layouts) copy-paste `main.dart`.

Also remember to add the image through the `pubspec.yaml` config file.

With this starting point the idea is to have the application interactive in the form of a custom widget for the number of times the page has been favorited. Tap the star icon to add or remove the location from the favorites, and in so doing modify the appearance of the icon and the accompanying counter.

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
