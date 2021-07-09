library after_layout;

import 'package:flutter/widgets.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback.then(
      (_) {
        if (mounted) afterFirstLayout(context);
      },
    );
  }

  void afterFirstLayout(BuildContext context);
}
