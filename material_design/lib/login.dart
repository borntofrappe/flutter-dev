import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _unfocusedColor = Colors.grey[600];
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
          const SizedBox(height: 80.0),
          Column(children: <Widget>[
            Image.asset('assets/diamond.png'),
            const SizedBox(height: 16.0),
            Text(
              'SHRINE',
              style: Theme.of(context).textTheme.headline5,
            ),
          ]),
          const SizedBox(height: 120.0),
          TextField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: _usernameFocusNode.hasFocus
                          ? Theme.of(context).colorScheme.secondary
                          : _unfocusedColor))),
          const SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: _passwordFocusNode.hasFocus
                        ? Theme.of(context).colorScheme.secondary
                        : _unfocusedColor)),
            obscureText: true,
          ),
          ButtonBar(children: <Widget>[
            TextButton(
                child: const Text('CANCEL'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                  shape: MaterialStateProperty.all(const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)))),
                ),
                onPressed: () {
                  _usernameController.clear();
                  _passwordController.clear();
                }),
            ElevatedButton(
                child: const Text('NEXT'),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8.0),
                    shape: MaterialStateProperty.all(
                        const BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0))))),
                onPressed: () {
                  Navigator.pop(context);
                })
          ])
        ])));
  }
}
