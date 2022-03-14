import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialCount(count: 128),
    );
  }
}

class InitialCount extends StatefulWidget {
  final int count;
  const InitialCount({Key? key, required this.count}) : super(key: key);

  @override
  State<InitialCount> createState() => _InitialCountState();
}

class _InitialCountState extends State<InitialCount> {
  final int _columns = 3;
  final int _rows = 10;

  late List<FixedExtentScrollController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = List<FixedExtentScrollController>.generate(
        _columns, (index) => FixedExtentScrollController());

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      int _count = widget.count;
      int _index = _columns - 1;
      while (_count > 0) {
        int _digit = _count % 10;

        _controllers[_index].jumpToItem(_digit);
        _index -= 1;
        _count = _count ~/ 10;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    for (FixedExtentScrollController _controller in _controllers) {
      _controller.dispose();
    }
  }

  void _updateCounter(int direction) {
    int currentIndex = _controllers.length;
    do {
      currentIndex -= 1;
      _controllers[currentIndex].animateToItem(
          _controllers[currentIndex].selectedItem + 1 * direction,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOutQuart);
    } while (currentIndex > 0 &&
        ((direction == 1 &&
                (_controllers[currentIndex].selectedItem) % _rows ==
                    _rows - 1) ||
            (direction == -1 &&
                (_controllers[currentIndex].selectedItem) % _rows == 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  _updateCounter(-1);
                }),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _updateCounter(1);
                })
          ]),
        ),
        Expanded(
          child: Row(
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
                              ))))))),
        ),
      ],
    ));
  }
}
