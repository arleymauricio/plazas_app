import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

/// Provider to make an instance of AuthService available to the app.
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async {
    _logger.i('Starting Google SSO sign-in flow');
    try {
      _logger.d('Opening Google sign-in dialog');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _logger.w('User cancelled Google sign-in');
        throw Exception('Google sign-in was cancelled by the user.');
      }
      _logger.i('User selected: ${googleUser.email}');

      _logger.d('Retrieving Google authentication tokens');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      _logger.d(
        'Google auth tokens received: has accessToken=${googleAuth.accessToken != null}',
      );

      _logger.i('Creating Firebase credential');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _logger.i('Signing into Firebase with Google credential');
      final userCred = await _auth.signInWithCredential(credential);
      _logger.i('Firebase sign-in succeeded, uid=${userCred.user?.uid}');
      return userCred;
    } on FirebaseAuthException catch (e, st) {
      _logger.e('Firebase Auth Error in Google sign-in', e, st);
      throw Exception('Firebase error: ${e.message}');
    } catch (e, st) {
      _logger.e('Error in Google sign-in flow', e, st);
      throw Exception('An unexpected error occurred during sign-in.');
    }
  }

  Future<void> signOut() async {
    _logger.i('Signing out user');
    await _googleSignIn.signOut();
    await _auth.signOut();
    _logger.i('Sign-out complete');
  }
}
