import 'package:flutter_test/flutter_test.dart';
import 'package:medibridge/main.dart';

void main() {
  testWidgets('MediBridge app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MediBridgeApp());

    // Verify the app title is displayed.
    expect(find.text('MediBridge'), findsOneWidget);
    expect(find.text('Medical Language Assistant'), findsOneWidget);
  });
}
