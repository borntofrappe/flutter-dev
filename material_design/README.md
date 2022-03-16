# material_design

Follow the codelabs on [flutter.dev](https://codelabs.developers.google.com/codelabs/mdc-101-flutter) to learn about material design.

_Please note_: Instead of beginning the project from starter repo I try to recreate the application on my own.

## Material Components Basics

[The first codelab](https://codelabs.developers.google.com/codelabs/mdc-101-flutter) focused on the components for the login page.

### Setup

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

### Add TextField widgets

The codelab explains the use of `TextField` for username and password. The widget allows to include a floating label and a _touch ripple_, meaning feedback as the user taps the general area.

The course also motivates the `ListView` widget from the previous section to create a _scrollable_ column.

Place the widgets after the last `SizedBox`, separating the two vertically with an additional box widget.

```text
TextField
SizedBox
TextField
```

In terms of properties:

- use `decoration` to add a floating label

- use `obscureText` on the password field to hide the input

For the decoration add a `filled` property to ensure the field is visually separated from the background of the application.

```dart
const InputDecoration(
    filled: true,
    labelText: 'Username'
)
```

### Add buttons

For the login page the course describes two buttons and two widgets: `TextButton` and `ElevatedButton`. The choice is to have the text version describe a secondary action, as opposed to the primary action behind the elevated, more prominent piece of UI.

The codelab also introduces the `ButtonBar` widget as a wrapper around the buttons.

```text
ButtonBar
    TextButton
    ElevatedButton
```

Include a placeholder callback function in the `onPressed` field to avoid having the widget rendered as disabled.

#### Controllers

In the login widget define two controllers for the input fields.

```dart
final _usernameController = TextEditingController();
final _passwordController = TextEditingController();
```

Update the `TextField` widgets to include the controllers through the `controller` property.

```dart
TextField(controller: _usernameController)
TextField(controller: _passwordController)
```

#### onPressed

In the text button refer to the controllers to clear both input fields.

```dart
onPressed: () {
    _usernameController.clear();
    _passwordController.clear();
})
```

In the elevated button use the `Navigator` object to remove the login page and move back to the home screen — see the next section.

```dart
onPressed: () {
    Navigator.pop(context);
})
```

#### Pages

`Navigator.pop(context)` works to remove the login page and move _back_ to the home page. To this end you need to update the structure of the application.

Looking through the starter project:

- in `main.dart` return an instance of `ShrineApp` from `app.dart`

- in `app.dart` create a stateless widget which returns an instance of `MaterialApp` with a particular set of fields

- add the home widget to `home`

- set the initial route to `/login`. The idea is to push the login page immediately above the home page

- set `onGenerateRoute` to handle the navigation

- define `_generateRoute` to return `null` **or** the login route if the name of the input route indeed matches `/login`
