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

## [named_routes](https://codepen.io/borntofrappe/pen/YzYrvoe)

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
