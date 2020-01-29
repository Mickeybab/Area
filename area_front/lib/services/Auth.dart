// Auths
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Models
import 'package:area_front/models/User.dart';

// Responsible of all Auth Process
class AuthService {
  /// Instance of Firebase to handle oauth Procedures
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Google Handle the selection of the Google Account and ask for permission
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  /// Detect auth changes
  Stream<User> get user {
    print("User change");
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      throw new AuthException(error.code, error.message);
    }
  }

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      throw new AuthException(error.code, error.message);
    }
  }

  Future signOut() async {
    try {
      print("log out asked");
      return await _auth.signOut();
    } catch (error) {
      print("log out failed");
      print(error.toString());
      return null;
    }
  }
}
