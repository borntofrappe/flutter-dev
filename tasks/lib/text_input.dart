import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(() {
      setState(() {
        _isEmpty = _controller.text.isEmpty;
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _controller,
                focusNode: _focusNode,
                onFieldSubmitted: (String text) {
                  if (text.isNotEmpty) {
                    print(text);
                    _controller.clear();
                  } // consider whether or not to retain focus
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.check_box_outline_blank_rounded,
                    size: 24.0,
                  ),
                  hintText: 'Create task',
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Done',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    onPressed: _isEmpty
                        ? null
                        : () {
                            print(_controller.text);
                            _controller.clear();
                            _focusNode.unfocus();
                          },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
