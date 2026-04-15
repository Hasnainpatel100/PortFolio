// Portfolio widget test
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proftolio/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyPortfolioApp());

    // Verify app loads
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
