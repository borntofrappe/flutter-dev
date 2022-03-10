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

_Please note_: to rehearse the lessons learned with previous tutorials I tried to create the layout on my own.
