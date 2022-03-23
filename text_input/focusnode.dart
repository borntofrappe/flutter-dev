import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FormFocusNode()));
}

class FormFocusNode extends StatefulWidget {
  const FormFocusNode({Key? key}) : super(key: key);

  @override
  State<FormFocusNode> createState() => FormFocusNodeState();
}

class FormFocusNodeState extends State<FormFocusNode> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: TextField(focusNode: _focusNode)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _focusNode.requestFocus();
            },
            child: const Icon(Icons.edit)));
  }
}
