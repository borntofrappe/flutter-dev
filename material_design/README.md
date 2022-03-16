# material_design

> Instead of beginning the project from starter repo I try to recreate the application on my own.

## Setup

Require the images and fonts from the yaml config file.

```yaml
assets:
  - assets/

fonts:
  - family: Rubik
    fonts:
      - asset: fonts/Rubik-Regular.ttf
      - asset: fonts/Rubik-Medium.ttf
```

In `main.dart` import the login component from `login.dart` and include the widget in an instance of material app in the `home` field.

```dart
runApp(const MaterialApp(
  title: 'Shrine',
  home: LoginPage()
));
```

As the application will later include multiple screens it is likely the more appropriate field is actually `routes`, but I will update the code as needed.

In `login.dart` create a stateful widget which resembles the one highlighted [in the codelab](https://codelabs.developers.google.com/codelabs/mdc-101-flutter#2).

```text
Scaffold
    SafeArea
        ListView
            SizedBox
            Column
                Image.asset
                SizedBox
                Text
            SizedBox
```

`SizedBox` is used to add whitespace.

`ListView` works to show items in a list, and I am unsure as to why the widget is chosen in place of `Column` to show the content.
