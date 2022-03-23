import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: SafeArea(child: FormChanged()))));
}

class FormChanged extends StatefulWidget {
  const FormChanged({Key? key}) : super(key: key);

  @override
  State<FormChanged> createState() => FormChangedState();
}

class FormChangedState extends State<FormChanged> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        print(text);
      },
    );
  }
}
