import 'package:ejary_app/core/widgets/ejary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EjaryButton renders label and handles tap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EjaryButton(
            label: 'Sign In',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Sign In'), findsOneWidget);
    await tester.tap(find.text('Sign In'));
    expect(tapped, isTrue);
  });
}