import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:after_layout/after_layout.dart';

void main() {
  testWidgets('TestWidget', (WidgetTester tester) async {
    int runCount = 0;
    await tester.pumpWidget(TestWidget(callback: () => runCount++));
    expect(runCount, 1);
  });
}

@immutable
class TestWidget extends StatefulWidget {
  const TestWidget({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final VoidCallback callback;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with AfterLayoutMixin<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    widget.callback();
  }
}
