import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: const Text('Go to slider'),
          onPressed: () async {
            final value = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const SecondRoute(),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gotcha. You picked $value.'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondouteState();
}

class _SecondouteState extends State<SecondRoute> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Value',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
                value: _value,
                max: 100,
                min: 0,
                divisions: 10,
                label: _value.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _value = value;
                  });
                }),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.pop(context, _value.round());
              },
            ),
          ],
        ),
      ),
    );
  }
}
