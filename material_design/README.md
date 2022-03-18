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

## Material Theming

[The codelab](https://codelabs.developers.google.com/codelabs/mdc-103-flutter) focuses on theming with color, shape, elevation and type.

More so than previous codelabs the course points to specific widgets and properties, so that it I prefer to preface each section with a paragaph or two illustrating the key takeaways of each chapter.

### Change the color

A material app and material widgets rely on a set of colors from a theme. Customize the theme to have the color preference cascade throughout the entire application.

---

Create `colors.dart` to specify a few color values in hex color and one color from the `Colors` class, pointing to the Material color palette.

```dart
const kShrinePink50 = Color(0xFFFEEAE6);
const kShrinePink100 = Color(0xFFFEDBD0);

// ...
const kShrineBackgroundWhite = Colors.white;
```

In `app.dart` import the color file and define an instance of `ThemeData` with an helper function.

```dart
final ThemeData _kShrineTheme = _buildShrineTheme();
```

In the body of the function initialize a light theme as a base and include the color values from the custom file in specific properties.

```dart
final ThemeData base = ThemeData.light();

return base.copyWith(
  colorScheme: base.colorScheme.copyWith(
    primary: kShrinePink100,
    onPrimary:kShrineBrown900 ,
    secondary: kShrineBrown900,
    error: kShrineErrorRed,
  )
);
```

Include the theme in the material app widget.

```dart
MaterialApp(
  title: 'Shrine',
  theme: _kShrineTheme,
)
```

This has the immediate effect of replacing the default color with the chosen hues.

### Modify typography and label styles

A material app defines a set of styles for text, detailing the size and weight through different properties. Include the values through the theme available on the `context` variable.

---

Require a custom font in the configuration file.

```yaml
fonts:
  - family: Rubik
    fonts:
      - asset: fonts/Rubik-Regular.ttf
      - asset: fonts/Rubik-Medium.ttf
        weight: 500
```

With this setup the application is able to rely on the fonts at the chosen weights.

In the login page update the uppercase text to show a larger headline.

```dart
Text(
  'SHRINE',
  style: Theme.of(context).textTheme.headline5,
)
```

In `app.dart` create a separate helper function to modify a few default options set on the base theme with regards to text.

```dart
base.copyWith(
  headline5: base.headline5!.copyWith(
    fontWeight: FontWeight.w500,
  ),
  // ..
)
```

Apply the chosen font with a specific color for all text styles.

```dart
base.copyWith()
  .apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  )
```

Include theme in `_buildShrineTheme` extending the text theme of the base instance in the `textTheme` property.

```dart
textTheme: _buildShrineTextTheme(base.textTheme)
```

Alongside the theme update the selection theme to use a color from the provided variables.

```dart
textSelectionTheme: const TextSelectionThemeData(selectionColor: kShrinePink100)
```

The course continues updating the UI as a matter of preference, but always through values on the theme:

- reduce the importance of the text describing the price in the home screen

- center the text in the home screen in the bottom of each card

- change the theme of the input fields through the theme tapping in the `inputDecorationTheme` property

- remove the fill on the text fields

- always through the input theme add a `focusedBorder` with a stronger contrast to ensure the input is clearly visible

- in the login page update the style of the decorations' labels through `labelStyle`, again to ensure the text be clearly visibile

- define two focus nodes to change the appearance of the labels when the fields receive focus

### Adjust elevation

- remove the elevation set by default on the `Card` widgets

- update the elevation for the `ElevatedButton` widget

### Add shape

In `app.dart` import an additional script provided in the GitHub repo to add rounded corners.

```dart
import 'package:material_design/supplemental/cut_corners_border.dart';
```

Update the instance of `InputDecorationTheme` to use the specific `CutCornersBorder()` class instead of the previous `OutlineInputBorder()`.

To have the buttons mirror a similar border add a `BeveledRectangleBorder` in the login page.

Add the shape to the text button as well so that, even if without a solid background, the shape is shown as the button is clicked.

### Change the layout

To have cards positioned and sized with more flair replace `GridView` with `AsymmetricView`. The widget is provided in an additional script from the GitHub repo.

```dart
import 'package:material_design/supplemental/asymmetric_view.dart';
```

### Try another theme

With the implemented theming it is possible to radically change the appearance by modifying the starting values.

## Material Advanced Components

[The codelab](https://codelabs.developers.google.com/codelabs/mdc-104-flutter) focused on tweaking the existing application with advanced topics such as shape and motion.

### Add the backdrop menu

A backdrop menu as a custom widget composed of multiple widgets. The idea is to use a `Stack` widget to position a front and back layer in the same area and have the backdrop manage the front's visibility.

In `home.dart` start by removing the application bar so that the build method returns only `AsymmetricView`.

In `backdrop.dart` create `Backdrop` as a stateful widget which returns a `Scaffold` widget with a similar `appBar` _and_ a stack built with a helper function.

```dart
return Scaffold(
  appBar: appBar,
  body: _buildStack(),
);
```

For the application bar create the widget in the build method. Set specifically an elevation value to avoid showing a shadow below the widget.

```dart
elevation: 0.0,
```

For the `_buildStack` function return a `Stack` widget with a key and two children widgets picked up from the widget constructor.

```dart
return Stack(
  key: _backdropKey,
  children: <Widget>[
    widget.backLayer,
    widget.frontLayer,
  ]
);
```

To this end define the key as an instance of `GlobalKey`

```dart
final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
```

Update the definition of the widget to receive the back and front layers.

```dart
final Widget backLayer;
final Widget frontLayer;
const Backdrop({
  required this.backLayer,
  required this.frontLayer,
  Key? key}) : super(key: key);
```

In `app.dart` import the Backdrop widget and include an instance in the `home` field.

```dart
home: Backdrop(),
```

As a front layer use the home screen, as a tentative back layer use a container with a solid background.

```dart
home: Backdrop(backLayer: Container(color: kShrinePink100), frontLayer: const HomePage()),
```

Note that to see the colored background you need to remove the default background color on the home screen's scaffold.

```dart
backgroundColor: Colors.transparent,
```

### Add a shape

The idea is to wrap the front layer received through `Backdrop` in a `Material` widget to add a custom shape.

```diff
widget.frontLayer
+_FrontLayer(child: widget.frontLayer),
```

Define `_FrontLayer` as a stateless widget which receives a `child` widget.

```dart
final Widget child;
const _FrontLayer({ required this.child, Key? key }) : super(key: key);
```

Return the `child` through the mentioned `Material` widget in a specific widget tree.

```text
Column
  Expanded
    child
```

The column is to ultimately incorporate other widgets before the child.

For the shape use an instance of `BeveledRectangleBorder`.

```dart
shape: const BeveledRectangleBorder(
  borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
),
```

### Add motion

The idea is to show the back layer animating the widget from the left.

In `backdrop.dart` define a variable to manage the speed of the fling animation.

```dart
const double _kFlingVelocity = 2.0;
```

In the stateful widget create a controller managing its existance with the initState and dispose lifecycle methods.

```dart
late AnimationController _controller;
```

With dispose dispose of the resources allocated to the same entity.

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

With initState instantiate the controller.

```dart
_controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    value: 1.0,
    vsync: this
  );
```

Include the functionality of a specific mixin so that `this` refers to a ticker provider, an object necessary to run the animation.

```dart
class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {}
```

To manage the visibility of the back layer create two functions.

Create a getter function to check the animation's status, specicially if the status points to the back layer being visible.

```dart
bool get _frontLayerVisible {
  final AnimationStatus status = _controller.status;
  return status == AnimationStatus.completed ||
      status == AnimationStatus.forward;
}
```

Create a separate function to run the animation.

```dart
void _toggleBackdropLayerVisibility() {
  _controller.fling(velocity: _frontLayerVisible? -_kFlingVelocity : _kFlingVelocity);
}
```

The negative value when the front layer is visible fligs the animation back.

In the stack wrap the back layer in an ExcludeSemantics widget. The idea is to remove the menu from the application's semantics when the menu is indeed supposed to be hidden.

```dart
ExcludeSemantics(
  child: widget.backLayer,
  excluding: _frontLayerVisible,
),
```

To ultimately animate the back layer the animation requires a specific sequence of widgets, so that this section is more imperative than previous ones:

- update `_buildStack` to receive a build context and box constraints

- define an animation with an instance of `RelativeRectTween`. The animation relies on a series of variables considering the height of the constraints object

- wrap `_FrontLayer` in a `PositionedTransition` widget using the animation

- in the `body` field of the scaffold's widget call `_buildStack` through a `LayoutBuilder` widget

- in the `onPressed` field of the application bar invoke the function toggling the menu's visibility

The animation has issues with the existing widget tree, so that to avoid errors you need to:

1. replace the `Columns` in the `product_columns.dart` with `ListView` widgets. This works to avoid overflow

2. update `imageAspectRatio` in `product_columns.dart` to consider a value of `0`

### Add a menu on the back layer

`category_menu_page.dart`

```
import 'package:material_design/colors.dart';
import 'package:material_design/model/product.dart';
```

```
Center
  Container
    ListView
      _buildCategory
```

`_buildCategory`

```
final categoryString = category.toString().replaceAll('Category.', '').toUpperCase();
```

```
GestureDetector
```

On tap execute the `onTap` callback.

```
onTap: () => onCategoryTap(category),
```

Based on `category == currentCategory`

```
Column
  SizedBox
  Text
  SizedBox
  Container
```

```
Padding
  Text
```

---

`ShrineApp` into a stateful widget to manage the category and the tapping function.

```
import 'package:material_design/model/product.dart';
import 'package:material_design/category_menu_page.dart';
```

```
Category _currentCategory = Category.all;
void _onCategoryTap(Category category) {
  setState(() {
    _currentCategory = category;
  });
}
```

Add category menu page as the back layer.

```
backLayer: CategoryMenuPage(
            currentCategory: _currentCategory, onCategoryTap: _onCategoryTap),
```

Changes the appearance of the menu, but not the items shown in the home screen. Update home page to receive the category and use it in `AsymmetricView`.

```
ProductsRepository.loadProducts(category)
```

Send from `app.dart`

```
frontLayer: HomePage(
  category: _currentCategory,
),
```

Close front layer with the `didUpdateWidget` lifecycle method.

```
import 'package:material_design/model/product.dart';
```

```
final Category currentCategory;
      required this.currentCategory,
```

```
@override
void didUpdateWidget(Backdrop old) {
  super.didUpdateWidget(old);
}
```

```
if(widget.currentCategory != old.currentCategory) {
  _toggleBackdropLayerVisibility();
} else if(!_frontLayerVisible) {
  _controller.fling(velocity: _kFlingVelocity);
}
```

In `backdrop.dart` GestureDetector the on the wrapper for the front layer

```
GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque)
```

Receive the value alongside the child widget.

```
final VoidCallback? onTap;
final Widget child;
```

Send the value from the instance of the backdrop state.

```
_FrontLayer(
    onTap: _toggleBackdropLayerVisibility,
    child: widget.frontLayer
)
```

### Add a branded icon

TODO: document branded icon section

```dart
home: Backdrop(
  backLayer: Container(color: kShrinePink100),
  frontLayer: HomePage(),
  backTitle: const Text('MENU'),
  frontTitle: const Text('SHRINE'),
)
```

```dart
title: _BackdropTitle(
  listenable: _controller.view,
  onPress: _toggleBackdropLayerVisibility,
  frontTitle: widget.frontTitle,
  backTitle: widget.backTitle,
),
```

```dart
class _BackdropTitle extends AnimatedWidget {
}
```

Shortcut to login page.
