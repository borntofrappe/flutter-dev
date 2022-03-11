import 'package:flutter/material.dart';

class ParentState extends StatefulWidget {
  const ParentState({Key? key}) : super(key: key);

  @override
  State<ParentState> createState() => _ParentStateState();
}

class _ParentStateState extends State<ParentState> {
  bool _active = true;

  void _toggleActive() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Own State',
        home: Scaffold(
            body: Center(
                child: TapBox(active: _active, onChanged: _toggleActive))));
  }
}

class TapBox extends StatelessWidget {
  final bool active;
  final Function onChanged;

  const TapBox({Key? key, required this.active, required this.onChanged})
      : super(key: key);

  void _handleTap() {
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
            child: Text(active ? 'Active' : 'Inactive',
                style: TextStyle(color: Colors.grey[100], fontSize: 28.0))),
        width: 156.0,
        height: 156.0,
        decoration: BoxDecoration(
          color: active ? Colors.green[400] : Colors.grey[500],
        ),
      ),
    );
  }
}
