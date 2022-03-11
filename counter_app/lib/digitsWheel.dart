import 'package:flutter/material.dart';

void main() => runApp(const DigitsWheel());

class DigitsWheel extends StatefulWidget {
  const DigitsWheel({
    Key? key,
  }) : super(key: key);

  @override
  DigitsWheelState createState() => DigitsWheelState();
}

class DigitsWheelState extends State<DigitsWheel> {
  late FixedExtentScrollController _controller;
  final int _childCount = 10;
  int _index = 0;

  void _updateIndex(int increment) {
    setState(() {
      _index = (_index + increment);
      _controller.animateToItem(_index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutSine);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digits Wheel',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Expanded(
              child: ListWheelScrollView.useDelegate(
                  onSelectedItemChanged: (int i) {
                    print((_childCount - i) % _childCount);
                  },
                  perspective: 0.003,
                  diameterRatio: 0.75,
                  overAndUnderCenterOpacity: 0,
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 100,
                  childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                          _childCount,
                          (index) => SizedBox(
                              width: 200,
                              height: 50,
                              child: FittedBox(
                                  child: Text(
                                      ((_childCount - index) % _childCount)
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))))))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
              child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 48.0,
                        icon: const Icon(Icons.add),
                        onPressed: () => _updateIndex(-1)),
                    IconButton(
                        iconSize: 48.0,
                        icon: const Icon(Icons.remove),
                        onPressed: () => _updateIndex(1)),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
