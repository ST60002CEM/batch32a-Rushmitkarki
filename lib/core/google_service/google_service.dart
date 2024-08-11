import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInServiceProvider =
    Provider<GoogleSignInService>((ref) => GoogleSignInService());

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<Either<Failure, Map<String, dynamic>>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return Left(Failure(error: 'Google Sign-In failed'));
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      return Right({
        'idToken': googleSignInAuthentication.idToken,
        'accessToken': googleSignInAuthentication.accessToken,
      });
    } catch (error) {
      print('Google Sign-In error: $error');
      return Left(Failure(error: 'Google Sign-In failed'));
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
  }
}
