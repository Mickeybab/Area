// Auths Tools
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

// Config
import 'package:global_configuration/global_configuration.dart';

//Model

/// Responsible of all Auth Process
class AuthService {
  /// Instance of Firebase to handle oauth Procedures
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Google Handle the selection of the Google Account and ask for permission
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: GlobalConfiguration().getString('GoogleSignInClientId'), scopes: [
        'https://mail.google.com/'
      ]);

  /// Depending on the credential [FirebaseAuth] will sign In or Up the user
  ///
  /// If the crédential are invalid, we throw an Exception
  Future signWithCredential(AuthCredential credential) async {
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    if (authResult == null) throw ("Look's like credential are invalid");
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return currentUser;
  }

  /// SignIn with Google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return this.signWithCredential(credential);
    } catch (e) {
      print('Got error when sign in with Google: $e');
      return null;
    }
  }

  /// Detect auth changes
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) {
      return user;
    });
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await user.sendEmailVerification();
    } catch (error) {
      print(error.toString());
      throw new AuthException(error.code, error.message);
    }
  }

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (!user.isEmailVerified) {
        throw new AuthException("auth/is-email-verified-error",
            "Please validate your email via the link sent to your email address.");
      }
    } catch (error) {
      print(error.toString());
      throw new AuthException(error.code, error.message);
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }
}
