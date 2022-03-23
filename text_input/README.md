# text_input

[flutter.dev](https://docs.flutter.dev) explains how to process text input through several recipes. The goal of this directory is to go through the documentation to rehearse the underlying concepts.

## [Create and style a text field](https://docs.flutter.dev/cookbook/forms/text-input)

### TextField

```dart
TextField()
```

By default Flutter adds an underline.

Add label/border/icon/hint/error with `InputDecoration` in the `decoration` property.

```dart
TextField(
    decoration: InputDecoration(
        hintText: 'Type over here'
    )
)
```

Set `decoration to `null` to remove the default underline.

```dart
TextField(
    decoration: null
)
```

### TextFormField

```dart
TextFormField(
    decoration: InputDecoration(
        labelText: 'Type over here'
    )
)
```

The widget expands `TextField` to to add validation, integration with other `FormField` widgets and other features.

### Form

Connected to the widget you have the [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html) class, optional container to wrap widgets associated with a form.

In `form.dart` the component includes a form with a text input, a button and a rudimentary form of validation for when the input is submitted without a value.

```
Form
    Column
        TextFormField
            decoration
            validator
        Padding
            ElevatedButton
                child
                onPressed
```

Access the state of the form through the key associated with the `Form` widget — see the next section.

```dart
// button
onPressed: () {
    print(_formKey.currentState!.validate());
}
```

Note that the `.validate()` method returns a boolean based on the logic of `validator` and the associated callback. Whenever you return `null` the value is validated.

```dart
validator: (String? value) {
    return null;
}
```

In the snippet the input would be always validated.

## [Build a form with validation](https://docs.flutter.dev/cookbook/forms/validation)

The recipe repeats the concepts of the previous section and example, but the repetition is worth the effort.

1. create a `Form` with a `GlobalKey`

   ```dart
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   // later
   Form(
       key: _formKey
   )
   ```

   The key identifies the form through the `key` property.

2. add a `TextFormField` and a `validator` property

   ```dart
   TextFormField(
       validator: (value) {}
   )
   ```

   `validator` describes a callback which receives a value. The value can be a string, but also `null`.

   ```dart
   validator: (String? value) {
       print(value);
   }
   ```

   To invalidate the input return a string with an error message.

   ```dart
   validator: (String? value) {
       if(value == null || value.isEmpty) {
           return 'Please enter some text';
       }
   }
   ```

   To validate the input return `null`.

   ```dart
   return null;
   ```

3. add a button to validate the form when the input is submitted

   ```dart
   onPressed: () {
       print(_formKey.currentState!.validate());
   }
   ```

`FormState` is automatically created by Flutter when building the form.

`validate()` runs the logic in the callback passed to the `validator` property and returns a boolean according tot he returned value.

**If** there are errors `validate()` also rebuilds the form to display the error message.

## [Handle changes to a text field](https://docs.flutter.dev/cookbook/forms/text-field-changes)

As the input of `TextField` or `TextFormField` changes consider the value through the `onChanged` callback _or_ a `TextEditingController`.

### onChanged

Add a callback to the `onChanged` property of a `TextField` or `TextFormField` widget.

```dart
onChanged: (text) {
    print(text);
},
```

The function receives the text passed through the input field.

### TextEditingController

Create a controller as a instance of `TextEditingController`.

```dart
final _controller = TextEditingController();
```

Dispose of the controller when the widget is removed

```dart
@override
void dispose() {
    _controller.dispose();
    super.dispose();
}
```

Add the instance to the `controller` property of a `TextField` or `TextFormField` widget.

```dart
controller: _controller
```

Listen to changes to the controller through a listener. Set up the listener as the widget is mounted.

```dart
@override
void initState() {
    super.initState();

    _controller.addListener(_listen);
}
```

The listener receives a callback function which is called as the controller changes.

```dart
void _listen() {
    print(_controller.text);
}
```

The `dispose` method removes the listener as well.

## [Retrieve the value of a text field](https://docs.flutter.dev/cookbook/forms/retrieve-input)

The recipe follows much of the same logic explained in the previous section with regards to the text editing controller.

The only difference is that, instead of considering the input as the value changes, the text is highlighted when the floating action button is clicked.

```dart
onPressed: () {
    print(_controller.text);
}
```

The recipe concludes highlighting the value in an `AlertDialog` widget.

## [Focus and text fields](https://docs.flutter.dev/cookbook/forms/focus)

The recipe illustrates how to focus ona text field programmatically.

### Autofucus

Set the `autofocus` property to focus on a text field as the widget becomes visible.

```dart
TextField(
    autoFocus: true
)
```

### Focus node

Create a `FocusNode` object to focus on a text field as a button is pressed.

1. create an instance of `FocusNode`

   ```dart
   late FocusNode _focusNode;
   ```

   Initialize the node as the widget is mounted.

   ```dart
   _focusNode = FocusNode();
   ```

   Dispose of the node when the widget is removed.

   ```dart
   _focusNode.dipose();
   ```

2. pass the instance to the text widget and through the `focusNode` property

   ```dart
   focusNode: _focusNode
   ```

3. manage focus with the node, for instance with the `requestFocus()` method

   ```dart
   onPressed: () {
       _focusNode.requestFocus();
   }
   ```
