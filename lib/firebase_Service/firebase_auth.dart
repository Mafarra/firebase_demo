// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuth {
  anonymouseSignIn(UserCredential? userCredential) async {
    try {
      userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("$userCredential \n Signed in with temporary account.");
      print("\n user ID : ${userCredential.user!.uid.toString()}");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  creatUserWithEmailAndPassword(UserCredential? userCredential) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "mam.farra2030@gmail.com", password: "123456789");
      print("$userCredential \n createUserWithEmailAndPassword.");
      print(
          "user email: \n ${userCredential.user?.email.toString() ?? "email is null"} ");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithEmailAndPassword(UserCredential? userCredential) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "mam.farra2030@gmail.com", password: "123456789");
      print("is emailVerified ? ${userCredential.user!.emailVerified}");
      print('user is signed in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    User user = FirebaseAuth.instance.currentUser!;
    checkIfUserVerified(user);
  }

  checkIfUserVerified(User? user) async {
    if (!user!.emailVerified) {
      await sendEmailVerification(user);
      print("verified email was sent");
    } else {
      print("Your email has been verified");
    }
  }

  sendEmailVerification(User? user) async {
    try {
      await user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('user is signed out');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }
    }
  }

  linkWithCredential(
      AuthCredential credential, UserCredential? userCredential) async {
    try {
      userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
  }
}
