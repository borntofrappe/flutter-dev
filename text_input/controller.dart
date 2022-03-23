import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: SafeArea(child: FormController()))));
}

class FormController extends StatefulWidget {
  const FormController({Key? key}) : super(key: key);

  @override
  State<FormController> createState() => FormControllerState();
}

class FormControllerState extends State<FormController> {
  final _controller = TextEditingController();

  void _listen() {
    print(_controller.text);
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_listen);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: _controller);
  }
}
