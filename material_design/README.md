# material_design

Follow the codelabs on [flutter.dev](https://codelabs.developers.google.com/codelabs/mdc-101-flutter) to learn about material design.

_Please note_: Instead of beginning the project from starter repo I try to recreate the application on my own.

## Material Components Basics

[The first codelab](https://codelabs.developers.google.com/codelabs/mdc-101-flutter) focuses on the components for the login page.

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

## Material Structure and Layout

The [second codelab](https://codelabs.developers.google.com/codelabs/mdc-102-flutter) focuses on the home screen.

### Add a top bar

In `home.dart` add the `appBar` field to the `Scaffold` widget.

```dart
Scaffold(
  appBar: AppBar(),
)
```

Scaffold is a convenient widget to include app navigation as well as drawers and floating action buttons.

In the instance of `AppBar` specify a title.

```dart
title: const Text('SHRINE'),
```

With the `leading` field add an icon button for an hypothetical menu.

```dart
leading: IconButton(),
```

The app widget provides helpful fields to add icons beore the title, but also after the string. With the `actions` field add two buttons at the end of the app bar for hypothetical search and filter functions.

```dart
actions: <Widget>[
  IconButton(),
  IconButton(),
]
```

Add a `semanticLabel` to the icon widgets.

```dart
icon: const Icon(
  Icons.menu,
  semanticLabel: 'menu',
)
```

### Add a card in a grid

A card works as a container for content as well as actions.

Add a `GridView` widget instead of the previous `Center` widget.

```dart
body: GridView.count()
```

`GridView.count` describes the grid with several properties:

- `crossAxisCount` points to the number of items in the non-scrolling axis. By default the value describes the number of columns

  ```dart
  crossAxisCount: 2,
  ```

- `childAspectRatio` ensures that the items have the same size, considering the width of the grid and padding

  ```dart
  childAspectRatio: 8.0 / 9.0,
  ```

- `children` includes the actual content in the grid — at first a single card widget

  ```dart
  children: <Widget>[Card()]
  ```

For the card add a `Card` widget with a `child` field. Here create a widget tree to display product info.

```text
Column
  AspectRatio
    Image.asset
  Padding
    Column
      Text
      SizedBox
      Text
```

`AspectRatio` describes the shape of the image.

```dart
AspectRatio(
  aspectRatio: 18.0 / 11.0,
  child: Image.asset(),
)
```

### Make a card collection

Extract the logic of the card in a dedicated function, with the goal of producing multiple cards for the `children` field.

```dart
children: __buildGridCards(context)
```

In the function produce one card for each product in a list loaded from a local file — see the next section for the product data.

```dart
List<Product> products = ProductsRepository.loadProducts(Category.all);
```

With the data refer to the values stored in the products objects. Include for instance the title of the product instead of an hard-coded string.

```dart
Text(product.name)
```

For the image update the boxFit property to ensure the images cover the same area in the cards.

```dart
fit: BoxFit.cover
```

For the text widgets use the font size established from `theme`, an instance of `ThemeData`.

```dart
final ThemeData theme = Theme.of(context);
```

The topic is the subject of the next codelab.

For the price include the value formatted through an instance of the internationalization library.

```dart
final NumberFormat formatter = NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString());

// formatter.format(product.price)
```

### Product data

For the products update the config file to install two libraries.

```dart
dependencies:
  intl: ^0.17.0
  shrine_images: ^2.0.1
```

`intl` provides a formatting function for price data.

`shrine_images` is a utility developed for the specific project to retrieve the images in the `packages` folder. To include the assets through the `Image.asset` widget update the config file in the `assets` field, listing the possible images.

```yaml
assets:
  - packages/shrine_images/0-0.jpg
  - packages/shrine_images/1-0.jpg
  - packages/shrine_images/2-0.jpg
  # ...
```

With this setup `home.dart` imports the internationalization library, but also two files provided in the GitHub repository.

```dart
import 'model/products_repository.dart';
import 'model/product.dart';
```

`products.dart` describes the class, the structure of each product through the different fields.

`products_repository.dart` provides a list of product instances.
