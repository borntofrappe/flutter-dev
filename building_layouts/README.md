# building_layouts

[The tutorial](https://docs.flutter.dev/development/ui/layout/tutorial) illustrates Flutter's approach to layout, and works as a companion to the [layout guide](https://docs.flutter.dev/development/ui/layout).

## Base code

Create a skeleton app with a first widget tree.

```text
Scaffold
    appBar
    body
        Center
            Text('Hello World')
```

## Diagram the layout

![Final layout](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes.jpg)

The page is divided in a column, containing an image, two rows and a block of text.

The first row is divided in three sections with a column of text, a star icon and a number. In the column you find two lines of text. Whatsmore, the column stretches to conver the available space — hinting at an `Expanded` widget.

The second row is divided in three sections, three columns laid side by side. Each column includes an icon and text — although it is likely the elements should be buttons.

The tutorial suggests a _bottom-up_ approach and to use variables and functions.

---

To rehearse the lessons learned with previous tutorials I tried to create the layout on my own. You can find this first implementation in `lib/naive.dart`.

Highlight the end result including the stateless widget in the `runApp` function instead of `App()`.

```diff
-runApp(const App());
+runApp(const Naive());
```

---

## Implement the title row

At the top of the `build` method create a `Widget` describing the title section. This widget is a container with some padding and the following tree structure.

```text
Row
    Expanded
        Column
            Container
                Text
            Text
    Icon
    Text
```

The second container nested in the column widget helps to separate the two text elements vertically. The tutorial adds whitespace in the form of bottom padding.

```dart
padding: const EdgeInsets.only(bottom: 8)
```

Include the widget in the `body` field of `Scaffold`, wrapping the helper structure in a column widget to ultimately display the content in rows.

```dart
Scaffold(
    body: Column(children: [titleSection]),
)
```

## Implement the button row

Past `titleSection` define a widget for the section devoted to the buttons. Since the section repeats much of the logic for the buttons however, create a helper function to return the widgets on the basis of color, icon and label-

```dart
Column _buildButtonColumn(Color color, IconData icon, String label) {}
```

Notice the return value which describes the column widget.

In the body of the function return a column with the following tree structure.

```dart
Icon
Container
    Text
```

Once again the container helps to separate the content, this time with top padding.

On the main axis align the content to have the icon and text centered.

```dart
mainAxisAlignment: MainAxisAlignment.center,
```

For the column the tutorial also adds a `mainAxisSize` property.

```dart
mainAxisSize: MainAxisSize.min,
```

While the property doesn't seem to affect the application [the documentation](https://api.flutter.dev/flutter/widgets/Flex/mainAxisSize.html) elaborates how the value is updated to handle the space in the main axis — here the column. With `min` the column is as tall as strictly necessary to render the icon and label.

With this setup produce the buttons calling the function.

```dart
_buildButtonColumn(color, Icons.share, 'SHARE');
```

For the color define the variable so that the buttons inherit the color from the theme.

```dart
Color color = Theme.of(context).primaryColor;
```

Create a widget for the section to nest the buttons in a row.

```dart
Row(
    children: [
        _buildButtonColumn(),
        _buildButtonColumn(),
        _buildButtonColumn(),
    ]
)
```

Align the items on the main axis to space the columns evenly.

```dart
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
```

Similarly to the title section, add the widget in the scaffold's column.

```dart
Scaffold(
    body: Column(children: [
        titleSection,
        buttonSection
    ]),
)
```

## Implement the text section

For the block of text define a padding widget with some padding and a single widget, `Text`.

Include in the column after the button section.

```dart
Scaffold(
    body: Column(children: [
        titleSection,
        buttonSection
        textSection
    ]),
)
```

The tutorial also argues for the `softWrap` property to consider word boundaries.

```dart
softWrap: true
```

## Implement the image section

Once the image is added to the `pubspec.yaml` config file add the image with the `Image.asset` widget directly in the scaffold's column.

```dart
Scaffold(
    body: Column(children: [
        Image.asset(),
        titleSection,
        buttonSection
        textSection
    ]),
)
```

In terms of property point to the image stored locall in the `images` folder and specify a width and height.

With `fit` expand the image to cover the container.

```dart
fit: BoxFit.cover
```

## Final touch

Replace the scaffold's column widget with a `ListView` widget. The widget supports scrolling for devices which are not tall enough.

```diff
-body: Column(children: [
+body: ListView(children: [
```

Without this precaution, and if you were to extend the content past the viewport, Flutter would highlight a ReferFlex overflow at the bottom.

```text
A RenderFlex overflowed by 203 pixels on the bottom.
```
