import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstRoute(),
      routes: {
        SecondRoute.routeName: (context) => SecondRoute(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == ThirdRoute.routeName) {
          final args = settings.arguments as ScreenArguments;

          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  ThirdRoute(title: args.title, message: args.message));
        }

        assert(false, '${settings.name} is not implemented');
        return null;
      },
    );
  }
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  final String _defaultTitle = 'Hello world';
  final String _defaultMessage = 'How are you on this fine day';

  late TextEditingController _title;
  late TextEditingController _message;

  @override
  void initState() {
    super.initState();

    _title = TextEditingController();
    _message = TextEditingController();

    _title.text = _defaultTitle;
    _message.text = _defaultMessage;
  }

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _title,
              decoration: InputDecoration(
                  label: Text('Title'), hintText: _defaultTitle),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _message,
              decoration: InputDecoration(
                  label: Text('Message'), hintText: _defaultMessage),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String title =
                    _title.text.isNotEmpty ? _title.text : _defaultTitle;
                String message =
                    _message.text.isNotEmpty ? _message.text : _defaultMessage;

                Navigator.pushNamed(context, SecondRoute.routeName,
                    arguments: ScreenArguments(title, message));
              },
              child: Text('I second that!'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                String title =
                    _title.text.isNotEmpty ? _title.text : _defaultTitle;
                String message =
                    _message.text.isNotEmpty ? _message.text : _defaultMessage;

                Navigator.pushNamed(context, ThirdRoute.routeName,
                    arguments: ScreenArguments(title, message));
              },
              child: Text('I third the emotion!'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  String title;
  String message;

  ScreenArguments(this.title, this.message);
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  static const routeName = '/second';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

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
              args.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(args.message),
            SizedBox(height: 16.0),
            TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.edit),
                label: Text('Back editing'))
          ],
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  final String title;
  final String message;

  const ThirdRoute({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  static const routeName = '/third';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(message),
            SizedBox(height: 16.0),
            TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.edit),
                label: Text('Back editing'))
          ],
        ),
      ),
    );
  }
}
