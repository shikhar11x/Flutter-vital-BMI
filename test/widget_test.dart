import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vital_bmi/main.dart';

void main() {
  testWidgets('VitalBMI app launches', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: VitalBMIApp()));
    expect(find.text('VitalBMI'), findsWidgets);
  });
}
