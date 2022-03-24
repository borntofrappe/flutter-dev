import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'About Dialog',
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(color: Colors.grey[100]),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.mode_comment_rounded),
            onPressed: () {
              showGeneralDialog(
                context: context,
                transitionBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) =>
                    SlideTransition(
                        child: child,
                        position: Tween<Offset>(
                                begin: const Offset(0.0, 1.0), end: Offset.zero)
                            .animate(animation)),
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) =>
                    Dialog(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Warning',
                              style: TextStyle(
                                  fontSize: 32.0, fontWeight: FontWeight.bold)),
                          const Text(
                              'This might just be a test of your emergency preparedness.'),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    child: const Text('Back'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                ElevatedButton(
                                    child: const Text('Okay'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Thanks for the validation')));
                                    })
                              ])
                        ]),
                  ),
                ),
              );
            }));
  }
}
