import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_legend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('displays all seat states with matching colors', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SeatLegend())),
    );

    expect(find.text('Available'), findsOneWidget);
    expect(find.text('Selected'), findsOneWidget);
    expect(find.text('Reserved'), findsOneWidget);
    expect(find.text('Disabled'), findsOneWidget);

    final indicatorColors = tester
        .widgetList<Container>(find.byType(Container))
        .map((container) => (container.decoration! as BoxDecoration).color)
        .toList();

    expect(indicatorColors, [
      AppColors.surface,
      AppColors.accent,
      AppColors.warning.withValues(alpha: 0.18),
      AppColors.disabled,
    ]);
  });
}
