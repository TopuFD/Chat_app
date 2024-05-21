
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/auth/user.dart';

class SignInGoogle {
  Future<Object?> myGoogleService() async {
    // Trigger the authentication flow
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
    return await Constant.firebaseAuth.signInWithCredential(credential);
  }
}
// class SignInGoogle {
//   Future<Object?> myGoogleService() async {
//     try {
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser == null) {
//         // The user canceled the sign-in
//         return null;
//       }

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Once signed in, return the UserCredential
//       return await Constant.firebaseAuth.signInWithCredential(credential);
//     } catch (e) {
//       // Handle error here
//       print(e);
//       return null;
//     }
//   }
// }
