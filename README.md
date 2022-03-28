# flutter-dev

> Learn Flutter by creating Flutter apps

A few remarks to preface the repository:

- the different folders include the `.dart` files located in the `lib` directory of an hypothetical Flutter project. You can test the output on [dartpad.dev](https://dartpad.dev/), but for those scripts which rely on static assets, for those scripts which rely on additional dependencies you need to setup a project

- remember to add a trailing comma to Flutter widget `,`. The formatting setup with the Flutter and Dart extensions heavily relies on this comma to indent nested objects

  ```diff
  Icon(
      Icons.add,
  -    size: 64.0
  +    size: 64.0,
  )
  ```

## startup_name_generator

Follow the codelabs on [flutter.dev](https://flutter.dev/docs/get-started/codelab) to create "your first Flutter app".

## building_layouts

Follow the tutorial on [flutter.dev](https://docs.flutter.dev/development/ui/layout/tutorial) with a focus on layout widgets.

## adding_interactivity

Follow the tutorial on [flutter.dev](https://docs.flutter.dev/development/ui/interactive) with a focus on interactivity.
