# navigation_recipes

Learn how Flutter manages [navigation](https://docs.flutter.dev/cookbook/navigation) between screens with the `Navigator` object,

## [navigation_basics](https://codepen.io/borntofrappe/pen/MWrEXxY)

Following the example of the recipe [_Navigate to a new screen and back_](https://docs.flutter.dev/cookbook/navigation/navigation-basics) move between two routes with `Navigator.push`.

How to:

1. create two stateless widget `FirstRoute` and `SecondRoute`, each with a `Scaffold`, an application bar and a button

2. from the instance of `MaterialApp` refer to `FirstRoute` in the `home` property

3. in the `onPressed` callback of the first button use the navigator global and `Navigator.push` specifically to add the second route _on top_ of the existing one

4. in `Navigator.push` pass the current context and `MaterialPageRoute`

5. in `MaterialPageRoute` add the required `builder` property with a function receiving the current context and returning the route-to-be

6. in the function return an instance of `SecondRoute`

7. in the `onPressed` callback of the second button use the navigator global and `Navigator.pop` to remove the current route and move back to the previous one

8. in `Navigator.pop` pass the current context

## [named_routes](https://codepen.io/borntofrappe/pen/VwyMGbo)

Following the example of the recipe [_Navigate with named routes_](https://docs.flutter.dev/cookbook/navigation/named-routes) move between two routes with `Navigator.pushNamed`.

As a setup create two stateless components `FirstRoute` and `SecondRoute`, each returning a `Scaffold` with an application bar and a button.

1. in the instance of `MaterialApp` add a map to the `routes` field

2. in the map describe the routes with a string and a callback function

In the map:

- the string works as the name of the route

- the function receives the context and returns the actual widget

By default `MaterialApp` refers to the widget named `/`. Change this default with the optional `initialRoute` property

3. use `Navigator.pushNamed` to add a route by name _on top_ of the current one

4. in `Navigator.pushNamed` pass the current context and name of the function

5. use `Navigator.pop` to remove the current route and move back to the previous one

6. in `Navigator.pop` pass the current context

[Pass arguments to a named route](https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments)

[Return data from a screen](https://docs.flutter.dev/cookbook/navigation/returning-data)

[Send data to a new screen](https://docs.flutter.dev/cookbook/navigation/passing-data)

[Animate a widget across screens](https://docs.flutter.dev/cookbook/navigation/hero-animations)

## [navigation_arguments](https://codepen.io/borntofrappe/pen/eYyGjev)

Following the example of the recipe [_Pass arguments to a named route_](https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments) move between two routes with `Navigator.pushNamed` and the `arguments` parameter.

As a setup create a stateful widget which allows to compose a title and a message. In this widget return a `Scaffold` with an application bar, the two text fields and two separate buttons, so to implement both solutions described in the recipe.

In the receiving route(s) display a title and message. Return a `Scaffold` with an application bar, the two strings and a button to move back to the editing route.

Create a class to describe the object making up the arguments — this structure will be relevant as you retrieve the arguments in a later section.

```dart
class ScreenArguments {
  String title;
  String message;

  ScreenArguments(this.title, this.message);
}
```

### Receiving routes

For both routes which are supposed to receive the arguments describe the name of the route with a static variable.

```dart
class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  static const routeName = '/second';

  // ...
}
```

### routes

> refer to the widget `SecondRoute`

Add the receiving route in the `routes` property of a material app.

```dart
MaterialApp(
  home: FirstRoute(),
  routes: {
    SecondRoute.routeName: (context) => SecondRoute(),
  },
)
```

Move to the route with `pushNamed` sending the title and message in the `arguments` field.

```dart
Navigator.pushNamed(
  context, SecondRoute.routeName,
  arguments: ScreenArguments(title, message)
);
```

In the receiving route retrieve the arguments in the `build` method through `ModalRoute.of(context)`.

```dart
final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
```

Thanks to the class `as ScreenArguments` you are able to then use the title and messages directly in the return statement.

```dart
Text(args.title)
Text(args.message)
```

### onGenerateRoute

> refer to the widget `ThirdRoute`

Add the `onGenerateRoute` field to the instance of the material app. This field describes a function which receives route settings.

```dart
onGenerateRoute: (RouteSettings settings) {}
```

The goal is to retrieve the name of the route through `settings`, specifically `settings.name`.

If the name matches the name of the desired route use `MaterialPageRoute` to produce the matching widget.

```dart
if (settings.name == ThirdRoute.routeName) {

  return MaterialPageRoute();
}
```

Retrieve the arguments sent through the routes through `settings`.

```dart
final args = settings.arguments as ScreenArguments;
```

Send the arguments as named properties to the component — this in the `builder` field required by `MaterialPageRoute`.

```dart
builder: (BuildContext context) =>
  ThirdRoute(
    title: args.title,
    message: args.message
)
```

In this instance the route receives the arguments in the definition of the widget.

```dart
class ThirdRoute extends StatelessWidget {
  final String title;
  final String message;

  const ThirdRoute({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);
}
```

## [returning_data](https://codepen.io/borntofrappe/pen/rNpGPgx)

Following the example of the recipe [_Return data from a screen_](https://docs.flutter.dev/cookbook/navigation/returning-data) return a value from a separate route.

As a setup create a stateful widget which manages the value of a slider. In this widget return a `Scaffold` with the slider and a button to move focus back from a preceding route.

Use `Navigator.pop` passing the current context _and_ the value of the slider itself.

```dart
Navigator.pop(context, _value.round());
```

To receive this value use `Navigator.push` as a future, a promise. In the beginning route move to the stateful widget with `MaterialPageRoute`.

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (BuildContext context) => const SecondRoute(),
  ),
)
```

Store the value returned from the separate route in a variable awaiting for the navigator's resolution.

```dart
final value = await Navigator.push(/* ... */)
```
