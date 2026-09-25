import 'package:cinema_booking/features/cinema_booking/presentation/widgets/booking_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('displays the supplied selection summary', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BookingSummary(
            selectedCount: 3,
            totalPrice: 150,
            onReset: () {},
          ),
        ),
      ),
    );

    expect(find.text('3/5'), findsOneWidget);
    expect(find.text('150.00 EGP'), findsOneWidget);
    expect(find.text('Reset Selection'), findsOneWidget);
  });

  testWidgets('forwards the reset action', (tester) async {
    var resetCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BookingSummary(
            selectedCount: 0,
            totalPrice: 0,
            onReset: () => resetCount++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Reset Selection'));

    expect(resetCount, 1);
  });
}
