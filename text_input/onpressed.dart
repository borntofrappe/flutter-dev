import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FormPressed()));
}

class FormPressed extends StatefulWidget {
  const FormPressed({Key? key}) : super(key: key);

  @override
  State<FormPressed> createState() => FormPressedState();
}

class FormPressedState extends State<FormPressed> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextField(controller: _controller),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: Text(_controller.text));
                  });
            },
            child: const Icon(Icons.text_fields)));
  }
}
