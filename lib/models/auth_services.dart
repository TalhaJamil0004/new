import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  signInWithGoogle() async {
    // interactive sign_in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // Do authentication for the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // new credentials
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    // lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
