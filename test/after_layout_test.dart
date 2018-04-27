import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:after_layout/after_layout.dart';

void main() {
	testWidgets('MyWidget', (WidgetTester tester) async {
		int runCount = 0;
		await tester.pumpWidget(new TestWidget(() => runCount++));
		expect(runCount, 1);
	});
}

class TestWidget extends StatefulWidget {
	final VoidCallback callback;

	const TestWidget(this.callback);

	@override
	_TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with AfterLayout<TestWidget> {
	@override
	Widget build(BuildContext context) {
		return Container();
	}

	@override
	void afterFirstLayout(BuildContext context) {
		widget.callback();
	}
}
