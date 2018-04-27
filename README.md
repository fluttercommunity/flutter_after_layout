# after_layout
[![pub package](https://img.shields.io/pub/v/after_layout.svg)](https://pub.dartlang.org/packages/after_layout)

Brings functionality to execute code after the first layout of a widget has been performed, i.e. after the first frame has been displayed.

## Motivation
If you want to display a widget that depends on the layout, such as a `Dialog` or `BottomSheet`, you can not use that widget in `initState`.

**Example:**
```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'After Layout - Bad Example',
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    showHelloWorld();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Container(color: Colors.red));
  }

  void showHelloWorld() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            content: new Text('Hello World'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('DISMISS'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
    );
  }
}
```


## Usage

This demo showcases how this package resolves the shortcomings shown above:

```dart
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'After Layout - Good Example',
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AfterLayout<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Container(color: Colors.red));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    showHelloWorld();
  }

  void showHelloWorld() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            content: new Text('Hello World'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('DISMISS'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
    );
  }
}
```
