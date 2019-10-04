library after_layout;

import 'package:flutter/widgets.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  bool _hasBeenCalled;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(true != _hasBeenCalled) {
        _hasBeenCalled = true;
        afterFirstLayout(context);
      }
    });
  }

  void afterFirstLayout(BuildContext context);
}
