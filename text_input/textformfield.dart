import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Type over here'))))));
}
