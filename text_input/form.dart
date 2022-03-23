import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: SafeArea(child: FormField()))));
}

class FormField extends StatefulWidget {
  const FormField({Key? key}) : super(key: key);

  @override
  State<FormField> createState() => FormFieldState();
}

class FormFieldState extends State<FormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Enter your email'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  }),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        print(_formKey.currentState!.validate());
                      }))
            ]));
  }
}
