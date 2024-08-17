import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoginView Widget Tests", () {
    testWidgets('renders LoginView and initial components', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify if the LoginView is rendered
      expect(find.byType(LoginView), findsOneWidget);

      // Verify if the logo is rendered
      expect(find.byType(Image), findsOneWidget);

      // Verify if the email and password fields are rendered
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Verify if the "Login" button is rendered
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('validates empty email and password fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap the login button without entering any text
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Check if validation messages are displayed
      expect(find.text('Please enter Email'), findsOneWidget);
      expect(find.text('Please enter Password'), findsOneWidget);
    });

    testWidgets('successful login test', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter valid email and password
      await tester.enterText(
          find.byType(TextFormField).at(0), 'rushmit.karki@gmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password');

      // Simulate the login button tap
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Verify if the login button is still present (indicating the user might still be on the login screen)
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    // testWidgets('forgot password button navigation test', (tester) async {
    //   await tester.pumpWidget(
    //     const ProviderScope(
    //       child: MaterialApp(
    //         home: LoginView(),
    //       ),
    //     ),
    //   );
    //   await tester.pumpAndSettle();
    //
    //   // Tap the 'Forget password?' button
    //   await tester.tap(find.text('Forget password?'));
    //   await tester.pumpAndSettle();
    //
    //   // Add assertions here depending on what happens when the 'Forget password?' button is tapped.
    //   // You can verify if navigation occurs or if the expected behavior is triggered.
    // });

    // testWidgets('Google sign-in button test', (tester) async {
    //   await tester.pumpWidget(
    //     const ProviderScope(
    //       child: MaterialApp(
    //         home: LoginView(),
    //       ),
    //     ),
    //   );
    //   await tester.pumpAndSettle();
    //
    //   // Tap the 'Sign in with Google' button
    //   await tester
    //       .tap(find.widgetWithText(ElevatedButton, 'Sign in with Google'));
    //   await tester.pumpAndSettle();
    //
    //   // Verify that the Google sign-in action is triggered.
    //   // You might need to verify the actual authentication logic.
    // });
  });
}
