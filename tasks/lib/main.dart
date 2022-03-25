import 'package:flutter/material.dart';
import 'package:tasks/empty_state.dart';

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
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: EmptyState(),
      ),
      floatingActionButton: _hasFocus
          ? null
          : FloatingActionButton(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: 'Go back to tasks',
                  context: context,
                  transitionBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) =>
                      SlideTransition(
                    child: child,
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                  ),
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) =>
                      StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) =>
                        Dialog(
                      alignment: Alignment.bottomCenter,
                      insetPadding: EdgeInsets.zero,
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
                        child: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                autofocus: true,
                                controller: _controller,
                                focusNode: _focusNode,
                                onChanged: (String text) {
                                  setState(() {
                                    _isEmpty = text.isEmpty;
                                  });
                                },
                                onFieldSubmitted: (String text) {
                                  if (text.isNotEmpty) {
                                    print(text);
                                    _controller.clear();
                                    setState(() {
                                      _isEmpty = true;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.check_box_outline_blank_rounded,
                                    color: Colors.black45,
                                    size: 24.0,
                                  ),
                                  hintText: 'Create task',
                                  hintStyle: TextStyle(color: Colors.black45),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8.0),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: _isEmpty
                                        ? null
                                        : () {
                                            print(_controller.text);
                                            _controller.clear();
                                            _focusNode.unfocus();
                                            setState(() {
                                              _isEmpty = true;
                                            });
                                            Navigator.pop(context);
                                          },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
