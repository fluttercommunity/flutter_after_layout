[![Flutter Community: after_layout](https://fluttercommunity.dev/_github/header/after_layout)](https://github.com/fluttercommunity/community)

# Flutter After Layout

[![pub package](https://img.shields.io/pub/v/after_layout.svg)](https://pub.dartlang.org/packages/after_layout)

Brings functionality to execute code after the first layout of a widget has been performed, i.e. after the first frame has been displayed.


## Quick Usage

Add `with AfterLayoutMixin<MyWidget>` mixin to your `State<MyWidget>` class and then implement the `void afterFirstLayout(BuildContext context)` abstract method. Code in this method will be called the first time this widget is laid out on the screen.


## Motivation
If you want to display a widget that depends on the layout, such as a `Dialog` or `BottomSheet`, you can not use that widget in `initState`.

You might have tried this.

**BAD CODE**
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'After Layout - Bad Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
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
    return Scaffold(body: Container(color: Colors.red));
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
```


## Usage

This demo showcases how this package resolves the shortcomings shown above:

**GOOD CODE**

```dart
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
```
