import 'package:final_assignment/features/forgotpassword/presentation/view/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ForgetPasswordView Widget Tests', () {
    testWidgets('renders ForgetPasswordView with expected widgets',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ForgetPasswordView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Check if the ForgetPasswordView is rendered
      expect(find.byType(ForgetPasswordView), findsOneWidget);
      // Check if the "Forget Password" text is displayed
      expect(find.text('Forget Password'), findsOneWidget);
      // Check if the phone number TextField is displayed
      expect(find.widgetWithIcon(TextFormField, Icons.phone), findsOneWidget);
      // Check if the "Submit" button is displayed
      expect(find.text('Submit'), findsOneWidget);
    });
  });
}
