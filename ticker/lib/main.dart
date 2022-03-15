import 'package:flutter/material.dart';

void main() {
  runApp(const Ticker());
}

const digits = 10;

class Ticker extends StatefulWidget {
  const Ticker({Key? key}) : super(key: key);

  @override
  State<Ticker> createState() => _TickerState();
}

class _TickerState extends State<Ticker> {
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  void _scroll(int direction) {
    _controller.animateToItem(_controller.selectedItem + 1 * direction,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine);
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ticker',
        home: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListWheelScrollView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 200.0,
                  children: List<Widget>.generate(
                      digits, (index) => FittedBox(child: Text(('$index'))))),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 48.0,
                    icon: const Icon(Icons.remove),
                    onPressed: () => _scroll(-1),
                  ),
                  IconButton(
                    iconSize: 48.0,
                    icon: const Icon(Icons.add),
                    onPressed: () => _scroll(1),
                  )
                ],
              ),
            )
          ],
        )));
  }
}
