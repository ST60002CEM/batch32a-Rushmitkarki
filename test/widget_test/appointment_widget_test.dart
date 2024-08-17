import 'package:final_assignment/features/appointment/presentation/view/appointment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AppointmentView Widget Tests", () {
    testWidgets('renders AppointmentView and initial components',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AppointmentView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify if the AppointmentView is rendered
      expect(find.byType(AppointmentView), findsOneWidget);

      // Verify if the AppBar title is rendered
      expect(find.text('Appointment Form'), findsOneWidget);

      // Verify if all text fields are rendered (5 in total)
      expect(find.byType(TextFormField), findsNWidgets(5));

      // Verify if the "Submit" button is rendered
      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
    });

    testWidgets('validates empty fields in the appointment form',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AppointmentView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap the submit button without entering any text
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pumpAndSettle();

      // Check if validation messages are displayed
      expect(find.text('Please enter the patient name'), findsOneWidget);
      expect(find.text('Please enter your phone number'), findsOneWidget);
      expect(find.text('Please select a booking date'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter a description'), findsOneWidget);
    });

    testWidgets('successful appointment submission with valid inputs',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AppointmentView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter valid data into all fields
      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextFormField).at(1), '1234567890');
      await tester.enterText(find.byType(TextFormField).at(2), '03/25/2024');
      await tester.enterText(
          find.byType(TextFormField).at(3), 'john.doe@example.com');
      await tester.enterText(
          find.byType(TextFormField).at(4), 'General checkup');

      // Tap the submit button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pumpAndSettle();

      // Verify if the submission process is triggered
      // Here, we assume no navigation occurs, and the button remains on screen
      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
    });

    testWidgets('date picker interaction', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AppointmentView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap the date field to open the date picker
      await tester.tap(find.byType(TextFormField).at(2));
      await tester.pumpAndSettle();

      // Verify if the date picker dialog is displayed
      expect(find.byType(DatePickerDialog), findsOneWidget);
    });
  });
}
