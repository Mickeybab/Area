// Auths Tools
import 'dart:io';

import 'package:area_front/backend/Backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Config
import 'package:global_configuration/global_configuration.dart';

// Models
import 'package:area_front/models/User.dart';

/// Responsible of all Auth Process
class AuthService {
  /// Instance of Firebase to handle oauth Procedures
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Google Handle the selection of the Google Account and ask for permission
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: GlobalConfiguration().getString('GoogleSignInClientId'));

  /// Depending on the credential [FirebaseAuth] will sign In or Up the user
  ///
  /// If the crédential are invalid, we throw an Exception
  Future signWithCredential(AuthCredential credential) async {
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    if (authResult == null) throw ("Look's like crédential are invalid");
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
      print('Got Error When Sign In : $e');
      return null;
    }
  }

  /// Create user object based on Firbase User
  Future<User> _userFromFirebaseUser(FirebaseUser user) async {
    final token = await user.getIdToken();

    print("ACCESS TOKEN: $token");
    return user != null ? User(uid: user.uid, client: Backend({HttpHeaders.authorizationHeader: token.toString()})) : null;
  }

  /// Detect auth changes
  Stream<Future <User>> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) async {
          print(user.toString());
          if (user != null && user.isEmailVerified)
            return await _userFromFirebaseUser(user);
          else
            return null;
        });
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await user.sendEmailVerification();
    } catch (error) {
      print(error.toString());
      throw new AuthException(error.code, error.message);
    }
  }

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user.isEmailVerified) {
        _userFromFirebaseUser(user);
      } else {
        throw new AuthException("auth/is-email-verified-error", "Please validate your email via the link sent to your email address.");
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
