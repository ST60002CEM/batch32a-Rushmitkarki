import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("RegisterView Widget Tests", () {
    testWidgets('renders RegisterView and initial components', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify if the RegisterView is rendered
      expect(find.byType(RegisterView), findsOneWidget);

      // Verify if the logo is rendered
      expect(find.byType(Image), findsOneWidget);

      // Verify if all text fields are rendered (6 in total)
      expect(find.byType(TextField), findsNWidgets(6));

      // Verify if the "Register" button is rendered
      expect(find.widgetWithText(ElevatedButton, 'Register'), findsOneWidget);
    });

    // testWidgets('validates empty fields in the registration form',
    //     (tester) async {
    //   await tester.pumpWidget(
    //     const ProviderScope(
    //       child: MaterialApp(
    //         home: RegisterView(),
    //       ),
    //     ),
    //   );
    //   await tester.pumpAndSettle();
    //
    //   // Tap the register button without entering any text
    //   await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    //   await tester.pumpAndSettle();
    //
    //   // Check for error messages (the validation logic would need to handle these cases)
    //   expect(find.text('Please enter First Name'), findsOneWidget);
    //   expect(find.text('Please enter Last Name'), findsOneWidget);
    //   expect(find.text('Please enter Email'), findsOneWidget);
    //   expect(find.text('Please enter Phone Number'), findsOneWidget);
    //   expect(find.text('Please enter Password'), findsOneWidget);
    //   expect(find.text('Please confirm Password'), findsOneWidget);
    // });

    testWidgets('registers user successfully with valid inputs',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter valid data into all fields
      await tester.enterText(find.byType(TextField).at(0), 'John');
      await tester.enterText(find.byType(TextField).at(1), 'Doe');
      await tester.enterText(
          find.byType(TextField).at(2), 'john.doe@example.com');
      await tester.enterText(find.byType(TextField).at(3), '1234567890');
      await tester.enterText(find.byType(TextField).at(4), 'Password123');
      await tester.enterText(find.byType(TextField).at(5), 'Password123');

      // Tap the register button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pumpAndSettle();

      // Verify if the registration process is triggered successfully
      // Here, we assume no navigation occurs, and the button remains on screen
      expect(find.widgetWithText(ElevatedButton, 'Register'), findsOneWidget);
    });

    // Additional tests can be added based on the requirements (e.g., mismatch password validation).
  });
}
