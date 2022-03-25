import 'package:flutter/material.dart';
import 'package:tasks/empty_state.dart';
import 'package:tasks/text_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyTasksPage(),
    );
  }
}

class MyTasksPage extends StatefulWidget {
  const MyTasksPage({Key? key}) : super(key: key);

  @override
  State<MyTasksPage> createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Align(
        alignment: Alignment.bottomCenter,
        child: TextInput(),
      ),
      floatingActionButton: null,
    );
  }
}
