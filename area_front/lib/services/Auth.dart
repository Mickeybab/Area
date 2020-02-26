// Auths Tools

import 'package:area_front/backend/Backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Config
import 'package:global_configuration/global_configuration.dart';

//Model
import 'package:area_front/models/Github.dart';

/// Responsible of all Auth Process
class AuthService {
  /// Instance of Firebase to handle oauth Procedures
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Google Handle the selection of the Google Account and ask for permission
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: GlobalConfiguration().getString('GoogleSignInClientId'));

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
  /// SignIn with Github
  Future signInWithGitHub(String code) async {
    try {
      final response = await http.post(
        GlobalConfiguration().getString('GithubAccessTokenUrl'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(GitHubLoginRequest(
          clientId: GlobalConfiguration().getString('GithubSignInClientId'),
          clientSecret: GlobalConfiguration().getString('GithubSignInClientSecret'),
          code: code,
        )),
      );

      final GitHubLoginResponse loginResponse =
          GitHubLoginResponse.fromJson(json.decode(response.body));

      final AuthCredential credential = GithubAuthProvider.getCredential(
        token: loginResponse.accessToken,
      );
      final FirebaseUser user = await this.signWithCredential(credential);
      Backend.post(user, '/services/github',
        headers: {
        }, body: {
          "token": loginResponse.accessToken,
          "refresh" : ""
        });
      return user;
    } catch (e) {
      print('Got error when sign in with Github: $e');
      return null;
    }
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
