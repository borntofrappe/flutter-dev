import 'package:flutter/material.dart';

class MixState extends StatefulWidget {
  const MixState({Key? key}) : super(key: key);

  @override
  State<MixState> createState() => _MixStateState();
}

class _MixStateState extends State<MixState> {
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

class TapBox extends StatefulWidget {
  final bool active;
  final Function onChanged;

  const TapBox({Key? key, required this.active, required this.onChanged})
      : super(key: key);

  @override
  State<TapBox> createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox> {
  bool _highlight = false;

  void _handleTap() {
    widget.onChanged();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
          border:
              _highlight ? Border.all(color: Colors.orange, width: 10.0) : null,
          color: widget.active ? Colors.green[400] : Colors.grey[500],
        ),
        child: Center(
            child: Text(widget.active ? 'Active' : 'Inactive',
                style: TextStyle(color: Colors.grey[100], fontSize: 28.0))),
        width: 156.0,
        height: 156.0,
      ),
    );
  }
}
