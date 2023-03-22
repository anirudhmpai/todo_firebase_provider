import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_firebase_provider/provider/base.dart';

class LoginProvider extends BaseProvider {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  LoginProvider() {
    {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          _isAuthenticated = true;
          notifyListeners();
        } else {
          _isAuthenticated = false;
          notifyListeners();
        }
      });
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Create a new credential
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }
}
