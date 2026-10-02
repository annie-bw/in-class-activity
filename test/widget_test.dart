import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:product_navigation/main.dart';

void main() {
  testWidgets('Tapping a product opens details and back returns home',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Product Navigation'), findsOneWidget);
    expect(find.text('Pixel'), findsOneWidget);

    await tester.tap(find.text('pixel 1'));
    await tester.pumpAndSettle();

    expect(find.text('Product Navigation'), findsNothing);
    expect(find.text('Pixel is the most featureful phone ever'), findsOneWidget);
    expect(find.text('Price: 800'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Product Navigation'), findsOneWidget);
  });
}
