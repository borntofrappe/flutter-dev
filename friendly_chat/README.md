# friendly_chat

[Building beautiful UIs with Flutter](https://codelabs.developers.google.com/codelabs/flutter)

The goal is to build a chat application where the user is able to send a message and immediately see the text above the text input.

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

The `main` function calls the class instead of instantiating `MaterialApp` on its own.

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
body: _buildTextComposer()
```


Define the function in the class to return the widget tree.


```dart
Widget _buildTextComposer() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text('It works')
  );
}
```



In the `child` field the goal is to add a `TextField` widget, a stateful widget with mutable state. To this end update `ChatScreen` to be mutable.




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


- controller refers to an object managing text input

- onSubmitted refers to a function called when the message is sent through the enter key

- decoration to describe the appearance of the widget — in the snippet specifically the decoration adds a placeholder

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


In the body of the function start by invoking the controller to clear the text input.

```dart
_textController.clear();
```



Next to the text field the goal is to add a button.

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
  onPressed: () {
    _handleSubmitted(_textController.text);
  },
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

2. nest the widget  into a scrollable list

3. nest the scrollable list in a Scaffold widget

With this setup you continue adding messages to the list in the form of single widgets.

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


Beside a margin to separate the messages vertically add a a row to nest multiple widgets.

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
final String _name = 'Timothy';
```

For the text of the mesasge define a variable and allow to change its value in the class constructor.

```dart
final String text;
const ChatMessage({ Key? key, required this.text }) : super(key: key);
```

With this setup you create a message invoking the function.

```dart
ChatMessage chatMessage = ChatMessage(text: 'Hello');
```

### Scrollable list

Update `_ChatScreenState` to define a list of messags.

```dart
final List<ChatMessage> _messages = [];
```

In the submit method use `setState` to add the latest message at the begining of the list.

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
focusNode: _focusNode,
```

In the submit function request focus after the set state.

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

Box decoration updates the style of the widget using the card color set on the theme.

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



Beside the function specify a padding and two additional fields: `reverse` and `itemCount`. The first field helps to show the messages in reverse order while the second field enumerates the number of items, so that the buildeer function contemplate every message.

```dart
ListView.builder(
  reverse: true,
  itemCount: _messages.length,
)
```

<!-- ## Animate your app -->

<!-- ## Apply finishing touches -->