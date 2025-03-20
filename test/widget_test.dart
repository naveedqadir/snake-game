// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:snake_game/main.dart';

void main() {
  testWidgets('Snake game launches correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    // Alternative class names that might be used:
    // await tester.pumpWidget(const SnakeGameApp());
    // await tester.pumpWidget(const App());
    // await tester.pumpWidget(const MainApp());

    // Verify that the app launches without errors
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Check for game elements - adjust these based on your actual implementation
    // For example, if you have a custom GameBoard widget:
    // expect(find.byType(GameBoard), findsOneWidget);
    
    // If you have a score display:
    // expect(find.byKey(const Key('scoreDisplay')), findsOneWidget);
    
    // If you have control buttons:
    // expect(find.byType(IconButton), findsWidgets);
  });
}
