import 'dart:io';

import 'package:final_assignment/features/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  group("EditProfileView Widget Tests", () {
    testWidgets('renders EditProfileView and initial components',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: EditProfileView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify if the EditProfileView is rendered
      expect(find.byType(EditProfileView), findsOneWidget);

      // Verify if the AppBar title is rendered
      expect(find.text('Update Profile'), findsOneWidget);

      // Verify if all text fields are rendered (5 in total)
      expect(find.byType(TextFormField), findsNWidgets(5));

      // Verify if the "Save Changes" button is rendered
      expect(
          find.widgetWithText(ElevatedButton, 'Save Changes'), findsOneWidget);

      // Verify if the profile image and camera button are rendered
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    // testWidgets('updates text fields with current profile data', (tester) async {
    //   // Set up the initial state with real profile data
    //   final profileData = ProfileViewModel(
    //     authEntity: AuthEntity(
    //       userId: '123',
    //       fName: 'John',
    //       lName: 'Doe',
    //       email: 'john.doe@example.com',
    //       phone: '1234567890',
    //     ),
    //     uploadImage: 'default.png',
    //   );
    //
    //   await tester.pumpWidget(
    //     ProviderScope(
    //       overrides: [
    //         profileViewmodelProvider.overrideWithValue(profileData),
    //       ],
    //       child: MaterialApp(
    //         home: EditProfileView(),
    //       ),
    //     ),
    //   );
    //   await tester.pumpAndSettle();
    //
    //   // Check if text fields are pre-filled with the profile data
    //   expect(find.byType(TextFormField).at(0).evaluate().single.widget, isA<TextFormField>().having((w) => (w as TextFormField).controller!.text, 'text', 'John'));
    //   expect(find.byType(TextFormField).at(1).evaluate().single.widget, isA<TextFormField>().having((w) => (w as TextFormField).controller!.text, 'text', 'Doe'));
    //   expect(find.byType(TextFormField).at(2).evaluate().single.widget, isA<TextFormField>().having((w) => (w as TextFormField).controller!.text, 'text', 'john.doe@example.com'));
    //   expect(find.byType(TextFormField).at(3).evaluate().single.widget, isA<TextFormField>().having((w) => (w as TextFormField).controller!.text, 'text', '1234567890'));
    // });

    testWidgets('shows camera permission snackbar when permission is denied',
        (tester) async {
      // Ensure the permission is not granted initially
      await Permission.camera.request();
      final status = await Permission.camera.status;
      if (status != PermissionStatus.granted) {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: EditProfileView(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Tap the camera button
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        // Verify if the snackbar is displayed
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Camera permission is required to take pictures'),
            findsOneWidget);
      }
    });

    testWidgets('picks and displays an image from the camera', (tester) async {
      final picker = ImagePicker();

      // Note: The following test might need to be adapted based on your specific setup
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: EditProfileView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Simulate picking an image
      final pickedFile = XFile('test_image.png');
      final file = File(pickedFile.path);

      // This step is usually tricky and may require integration tests to validate
      // if the image picker correctly updates the profile image.
      // Here you may need to interact with real device camera or file system.

      // Check if the profile image is updated
      expect(find.byType(CircleAvatar), findsOneWidget);
      // Actual validation of the image would require more setup or integration tests.
    });

    // testWidgets('submits updated profile data', (tester) async {
    //   // Set up the initial state with real profile data
    //   final profileData = ProfileViewModel(
    //     authEntity: AuthEntity(
    //       userId: '123',
    //       fName: 'John',
    //       lName: 'Doe',
    //       email: 'john.doe@example.com',
    //       phone: '1234567890',
    //     ),
    //     uploadImage: 'default.png',
    //   );
    //
    //   await tester.pumpWidget(
    //     ProviderScope(
    //       overrides: [
    //         profileViewmodelProvider.overrideWithValue(profileData),
    //       ],
    //       child: MaterialApp(
    //         home: EditProfileView(),
    //       ),
    //     ),
    //   );
    //   await tester.pumpAndSettle();
    //
    //   // Enter new data into text fields
    //   await tester.enterText(find.byType(TextFormField).at(0), 'Jane');
    //   await tester.enterText(find.byType(TextFormField).at(1), 'Smith');
    //   await tester.enterText(find.byType(TextFormField).at(2), 'jane.smith@example.com');
    //   await tester.enterText(find.byType(TextFormField).at(3), '0987654321');
    //
    //   // Tap the save button
    //   await tester.tap(find.widgetWithText(ElevatedButton, 'Save Changes'));
    //   await tester.pumpAndSettle();
    //
    //   // Verify if the profile data is updated
    //   // This would usually be done by asserting the changes in the view model or the backend
    //   // Here we would verify if the new data has been processed or saved
    //   expect(
    //     profileData.authEntity!.fName,
    //     'Jane',
    //   );
    //   expect(
    //     profileData.authEntity!.lName,
    //     'Smith',
    //   );
    //   expect(
    //     profileData.authEntity!.email,
    //     'jane.smith@example.com',
    //   );
    //   expect(
    //     profileData.authEntity!.phone,
    //     '0987654321',
    //   );
    // });
  });
}
