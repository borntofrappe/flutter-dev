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
  late FocusNode _focusNode;
  bool _hasFocus = false;

   @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: _focusNode.hasFocus ? null : FloatingActionButton(
        child: const Icon(
          Icons.add, 
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onSubmitted: (String text) {
                      Navigator.pop(context);
                    },
                    focusNode: _focusNode,
                    autofocus: true,
                  ),
                )
              )
            );
          });
        }
      ),
    );
  }
}
