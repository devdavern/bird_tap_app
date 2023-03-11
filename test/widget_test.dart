// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:bird_tap_app/ui/home/home_page.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HomePage());

    // Verify texts at home page.
    expect(find.text('Tap To Play'), findsOneWidget);
    expect(find.text('Score:\n\n0'), findsOneWidget);
    expect(find.text('Best:\n\n999'), findsOneWidget);
  });
}
