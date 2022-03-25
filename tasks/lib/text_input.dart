import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 420.0
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
        decoration:const  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.check_box_outline_blank_rounded, size: 24.0,),
                  hintText: 'Create task',
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                )
              ),
              Row(
            mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  TextButton(
                    child: Text('Done', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    onPressed: null,
                  ),
                ],
              )
            ]
          )
        ),
      ),
    );
  }
}