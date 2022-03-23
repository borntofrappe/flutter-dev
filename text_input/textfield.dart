import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: TextField(
                  decoration: InputDecoration(hintText: 'Type over here'))))));
}
