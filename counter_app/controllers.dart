import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Controllers(),
    );
  }
}

class Controllers extends StatefulWidget {
  const Controllers({Key? key}) : super(key: key);

  @override
  State<Controllers> createState() => _ControllersState();
}

class _ControllersState extends State<Controllers> {
  final int _columns = 3;
  final int _rows = 10;

  late List<FixedExtentScrollController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = List<FixedExtentScrollController>.generate(
        _columns, (index) => FixedExtentScrollController());
  }

  @override
  void dispose() {
    super.dispose();

    for (FixedExtentScrollController _controller in _controllers) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              int _wheel = 0;
              _controllers[_wheel].animateToItem(
                  _controllers[_wheel].selectedItem + 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOutQuart);
            }),
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.generate(
                _columns,
                (index) => Expanded(
                    child: Center(
                        child: ListWheelScrollView.useDelegate(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _controllers[index],
                            itemExtent: 200.0,
                            childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                              _rows,
                              (i) => FittedBox(
                                  fit: BoxFit.cover,
                                  child: Center(child: Text('$i'))),
                            ))))))));
  }
}
