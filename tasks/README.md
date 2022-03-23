# tasks

Create a todo application which allows to keep track of a series of tasks.

## Widgets

Before diving in the actual application I chose to focus on individual widgets to craft the UI of the application:

- `empty_state.dart` creates a visual for the home screen, and specifically for the instance in which there are no tasks

    The widget makes use of a stack component and a `BackDropFilter` to create a glass-like reflection between two boxes.

    It is possible to customize the widget with several properties, but how much the widget should be configurable is up to debate.