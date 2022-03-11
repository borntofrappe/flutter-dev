import 'package:flutter/material.dart';

class ChildState extends StatelessWidget {
  const ChildState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Own State', home: Scaffold(body: Center(child: TapBox())));
  }
}

class TapBox extends StatefulWidget {
  const TapBox({Key? key}) : super(key: key);

  @override
  State<TapBox> createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox> {
  bool _active = true;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
            child: Text(_active ? 'Active' : 'Inactive',
                style: TextStyle(color: Colors.grey[100], fontSize: 28.0))),
        width: 156.0,
        height: 156.0,
        decoration: BoxDecoration(
          color: _active ? Colors.green[400] : Colors.grey[500],
        ),
      ),
    );
  }
}
