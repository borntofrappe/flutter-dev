# [building_layouts](https://docs.flutter.dev/development/ui/layout/tutorial)

Flutter's approach to layout, and a companion tutorial to the [layout guide](https://docs.flutter.dev/development/ui/layout).

## Base code

A hello world application with the following widget tree.

```text
Scaffold
    appBar
    body
        Center
            Text('Hello World')
```

## Diagram the layout

The page is divided in a column, containing an image, two rows and a block of text.

The first row is subdivided in three sections with a column of text, a star icon and a number. In the column you find two lines of text. Whatsmore, the column stretches to conver the available space — hinting at an `Expanded` widget.

The second row is divided in three sections with three columns side by side. Each column contains an icon and text.

The tutorial suggests a _bottom-up_ approach and to use variables and functions.

## Aside

Before diving in the tutorial I try to create the layout on my own.
