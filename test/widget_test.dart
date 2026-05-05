// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clothes_shop/main.dart';

void main() {
  testWidgets('App boots and shows entry screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Avoid pumpAndSettle: splash uses animations that may never fully settle.
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 50));

    // We should land either on auth or home; both have a Scaffold.
    expect(find.byType(Scaffold), findsWidgets);

    // Basic sanity: app title exists.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
