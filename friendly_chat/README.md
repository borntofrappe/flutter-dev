# friendly_chat

Following the codelab [_Building beautiful UIs with Flutter_](https://codelabs.developers.google.com/codelabs/flutter) the goal is to build a chat application where the user is able to send a message and immediately see the text above the text input.

In terms of interface the application is designed with a series of widgets and customized to fit the operating system.

## Build the main user interface

As a starting point import the material library and use the `Scaffold` widget to nest an application bar.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'FriendlyChat',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FriendlyChat'),
        ),
      ),
    ),
  );
}
```

Restructure the application with two classes:

1. a root-level `FriendlyChatApp`

2. a child `ChatScreen` which rebuilds the interface when messages are sent and state changes

Both are initialized as stateless widget, although the chat screen will be made into a stateful one at a later stage.

For `FriendlyChatApp` extract `MaterialApp` into its own class.

```dart
class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyChat',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FriendlyChat'),
        ),
      ),
    );
  }
}
```

In the `main` function calls th class instead of instantiating `MaterialApp` on its own.

```dart

void main() {
  runApp(
    FriendlyChatApp()
  );
}
```

In `FriendlyChatApp` remove the `Scaffold` widget to reference an instance of `ChatScreen`.

```dart
home: ChatScreen()
```

Create the widget as a stateless widget typing "stless".

```dart
class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FriendlyChat'),
      ),
    );
  }
}
```

The output is essentially the same as the first snippet, but structured in multiple, dedicated components.

## Add a UI for composing messages

In the `body` field of the `Scaffold` widget add the widget tree from a dedicated function.

```dart
body: _buildTextComposer(),
```

Define the function to return the widget tree.

```dart
Widget _buildTextComposer() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text('It works')
  );
}
```

In the `child` field the goal is to add a `TextField` widget, a stateful widget with mutable state. To this end update `ChatScreen` to be stateful.

```dart
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

For the `TextField` widget add multiple fields.

```dart
TextField(
  controller: _textController,
  onSubmitted: _handleSubmitted,
  decoration: const InputDecoration.collapsed(
    hintText: 'Send a message',
  )
),
```

- `controller` refers to an object managing text input

- `onSubmitted` refers to a function called when the message is sent through the enter key

- `decoration` to describe the appearance of the widget — in the snippet specifically the decoration adds a placeholder

At the top of the stateful component define the controller as an instance of `TextEditingController`.

```dart
class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
}
```

Define also the submit function receiving a string as input.

```dart
void _handleSubmitted(String text) {
}
```

In the body of the function start by invoking the controller to clear the text input — this works to immediately show how the widget removes the content when pressing the enter key.

```dart
_textController.clear();
```

Next to the text field the goal is to add a button, so that the text is submitted by clicking the button as well.

Wrap the text widget in a `Row` widget.

```dart
Row(
  children: [
    TextField()
  ]
)
```

Wrap the text field in a `Flexible` widget.

```dart
Row(
  children: [
    Flexible(
      child: TextField()
    )
  ]
)
```

The step is necessary to have the input span the available width, considering the size of the screen and the size of the accompanying button.

For the button add an `IconButton` widget with an icon and a function invoked as the button is pressed.

```dart
IconButton(
  icon: const Icon(Icons.send),
  onPressed: () {},
)
```

In the function refer to the submit function with the text from the controller.

```dart
onPressed: () => _handleSubmitted(_textController.text),
```

In the `TextField` widget the function called through the `onSubmitted` automatically includes the text as input, but in the button you need to reference the content through the controller.

As a matter of preference wrap the button in a `Container` widget to separate the element horizontally.

```dart
Container(
  margin: const EdgeInsets.symmetric(horizontal: 4.0),
  child: IconButton()
)
```

Also as a matter of preference change the default style of the button, black, to use the set on a theme. To achieve this wrap the container in an `IconTheme` widget.

```dart
IconTheme(
  child: Container()
)
```

Add the required `data` field to specify a color.

```dart
data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
```

`context` describes the location of the widget in terms of the parent object, the state. This means you can change the theme at root level and have the change reflected in the widget.

## Add a UI for displaying messages

The UI for the messages is implemented in steps:

1. create a widget for a single chat message

2. nest the widget into a scrollable list

3. nest the scrollable list in the Scaffold widget

The idea is to continue adding messages to the list in the form of single widgets.

### ChatMessage

Create a stateless widget.

```dart
class ChatMessage extends StatelessWidget {
  const ChatMessage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
```

Beside a margin property to separate the messages vertically add a row to nest multiple widgets.

```dart
child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: []
)
```

In the row add a container and a column.

```dart
[
  Container(),
  Column(
    children: []
  ),
]
```

In the container add a `CircleAvatar` widget to display the first letter of a name

```dart
CircleAvatar(
  child: Text(_name[0])
),
```

In the column add a text for the full name and a container with the text for the message.

```dart
children: [
  Text(_name),
  Container(
    child: Text(text),
  ),
]
```

Define a string for the name.

```dart
final String _name = 'Gabriele';
```

For the text of the message define a variable to change its value in the class constructor.

```dart
final String text;
const ChatMessage({ Key? key, required this.text }) : super(key: key);
```

With this setup you'd create a message referencing the widget directly.

```dart
ChatMessage chatMessage = ChatMessage(text: 'Hello');
```

### Scrollable list

Update `_ChatScreenState` to define a list of messages.

```dart
final List<ChatMessage> _messages = [];
```

In the submit method use `setState` to add the latest message at the beginning of the list.

```dart
ChatMessage message = ChatMessage(
  text: text,
);

setState(() {
  _messages.insert(0, message);
});
```

As the message is sent the goal is to keep focus on the input field. To achieve this create an instance of a FocusNode object alongside the list of messages.

```dart
final FocusNode _focusNode = FocusNode();
```

Add the instance to the `focus` field of the `TextField` widget.

```dart
TextField(
  focusNode: _focusNode,
)
```

In the submit function request focus after you update the list of chat messages.

```dart
_focusNode.requestFocus();
```

### Scaffold

Modify the widget tree to include a column.

```dart
body: Column(
  children: []
)
```

As the last item of the list add a `Container` widget for the text input.

```dart
Container(
  decoration: BoxDecoration(
    color: Theme.of(context).cardColor,
  ),
  child: _buildTextComposer()
)
```

`BoxDecoration` updates the style of the widget using the card color set on the theme.

Before this container add a divider.

```dart
const Divider(height: 1.0),
```

Before the divider add a `Flexible` widget to wrap around a `ListView` widget.

```dart
Flexible(
  child: ListView.builder(

  )
),
```

In the builder include the list through the itemBuilder field. Here you specify a function which receives the context and the index of the item. In the collection the message is stored as an instance of `ChatMessage`, so that it's enough to reference the item directly.

```dart
ListView.builder(
  itemBuilder: (context, index) => _messages[index],
)
```

Beside the function specify a padding and two additional fields: `reverse` and `itemCount`. The first field helps to show the messages in reverse order while the second field enumerates the number of items, so that the builder function contemplates every message.

```dart
ListView.builder(
  reverse: true,
  itemCount: _messages.length,
)
```

## Animate your app

The goal is to have the messages translate vertically from the bottom of the screen. This is achieved with an animation controller.

Update `_ChatScreenState` to include the logic of the animation with a mixin.

```dart
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {}
```

Update `ChatMessage` to require an animation controller — made available through the mixin.

```dart
final AnimationController animationController;

const ChatMessage(
  final String text;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.animationController,
  }
) : super(key: key);
```

When creating a message passs an instance of `AnimationController` for the required field.

```dart
ChatMessage message = ChatMessage(
  text: text,
  animationController: AnimationController()
);
```

In the controller specify duration with a `Duration` object and vsync.

```dart
duration: const Duration(milliseconds: 700),
vsync: this,
```

`vsync` is required and points to the ticker provider, responsible for running the actual animation.

After you add the message in the list invoke the `animationController` to run the animation forward.

```dart
message.animationController.forward();
```

The animation runs, but it is necessary to tie the changing value to a value. To this end wrap the `Container` widget for the chat message in a `SizeTransition` widget.

```dart
return SizeTransition(
  child: Container()
)
```

Add the required `sizeFactor` field to describe an instance of `CurvedAnimation`

```dart
sizeFactor: CurvedAnimation(),
```

In the instance specify a required `parent` field and `curve`.

```dart
sizeFactor: CurvedAnimation(
  parent: null,
  curve: null,
),
```

For `parent` point to the animation controller, for `curve` use one of the constants from the `Curves` class.

```dart
parent: animationController,
curve: Curves.easeOut,
```

In the SizeTransition widget, and after the size factor, finally specify `axisAlignment`.

```dart
sizeFactor: CurvedAnimation(
),
axisAlignment: 0.0,
```

With this setup `SizeTransition` animates a rectangle to gradually expose the text.

### Dispose animations

As the widget is destroyed it is good practice to free the device from the resources used by the animation. To this end update `_ChatScreenState` through the `dispose` lifecycle method.

```dart
@override
void dispose() {
  super.dispose();
}
```

In the body of the function loop through the messages and refer to the controller to dispose of each animation.

```dart
for(ChatMessage message in _messages) {
  message.animationController.dispose();
}
```

## Apply finishing touches

In the final step the course updates the design of the application.

### Send button

The idea is to process text input only when the widget includes text.

In `_ChatScreenState` define a boolean to control the state of the input field.

```dart
bool _isComposing = false;
```

Update the boolean in two places:

1. in the TextField widget through the `onChanged` field

   The field describes a function which receives the text.

   ```dart
   TextField(
     onChanged: (text) {}
   )
   ```

   Depending on whether or not the text is an empty string update `_isComposing` through `setState`.

   ```dart
   setState(() {
     _isComposing = text.isNotEmpty;
   })
   ```

2. in the `_handleSubmit` method as the text field is cleared

   ```dart
   setState(() {
     _isComposing = false;
   });
   ```

Consider the boolean in several instances:

- in the `onSubmitted` field of the text widget to submit the text only if the boolean instructs a non-empty field

  ```dart
  onSubmitted = _isComposing ? _handleSubmitted: null,
  ```

- in the `onPressed` field of the button to achieve the same operation through the button

  ```dart
  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
  ```

### Wrap long lines

Wrap the `Column` widget responsible for the message in an `Expanded` widget.

```dart
Expanded(
  child: Column,
)
```

The widget imposes layout constraints so that the widget is limited to the screen's width.

Without this precaution Flutter highlights an overflow of some pixels.

### Themes

The idea is to change the theme and slightly tweak the appearance of the application considering the IOS operating system.

Import the foundation library.

```dart
import 'package:flutter/foundation.dart';
```

The module is necessary to evaluate the value of `defaultTargetPlatform`.

Define two themes as instances of `ThemeData`.

```dart
final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100]
);

final ThemeData kDefaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.purple
  ).copyWith(secondary: Colors.orangeAccent[400])
);
```

The idea is to use `kIOSTheme` if the platform matches IOS, And rely on `kDefaultTheme` otherwise.

Use `defaultTargetPlatform` directly to set the theme on the instance of `MaterialApp`.

```dart
return MaterialApp(
  title: 'FriendlyChat',
  theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
)
```

For nested widgets consider instead the platform set on the context of the parent widget.

```diff
-defaultTargetPlatform
+Theme.of(context).platform
```

Use the value to:

- change the elevation of the application bar

- change the widget used as a button, `CupertinoButton` or IconButton`

  For the cupertino button you need to require the necessary module.

  ```dart
  import 'package:flutter/cupertino.dart';
  ```

  Also for the cupertino variant the preference is to use text instead of an icon.

  ```dart
  child: const Text('Send')
  ```

- add a decoration to distinguish the body of the application — only on IOS

  ```dart
  BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.grey[200]!)
    )
  )
  ```
