import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'After Layout - Good Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.red));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    showHelloWorld();
  }

  void showHelloWorld() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Hello World'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('DISMISS'),
          )
        ],
      ),
    );
  }
}
