import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: SafeArea(child: FormAutofocus()))));
}

class FormAutofocus extends StatefulWidget {
  const FormAutofocus({Key? key}) : super(key: key);

  @override
  State<FormAutofocus> createState() => FormAutofocusState();
}

class FormAutofocusState extends State<FormAutofocus> {
  @override
  Widget build(BuildContext context) {
    return TextField(autofocus: true);
  }
}
