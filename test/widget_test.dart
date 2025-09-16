import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// your helper

void main() {
  testWidgets('CustomSnackbar displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    BannerToast.show(
                      context,
                      message: 'Toast Test',
                      type: BannerToastType.success,
                    );
                  },
                  child: const Text('Show SnackBar'),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Tap the button to trigger the snackbar
    await tester.tap(find.text('Show SnackBar'));
    await tester.pump(); // start animation

    // Verify SnackBar text appears
    expect(find.text('Hello Test'), findsOneWidget);
  });
}
