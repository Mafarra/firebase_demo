// ignore_for_file: avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Utils/sh_util.dart';
import 'package:firebase_demo/presentation/auth/login_screen.dart';
import 'package:firebase_demo/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../Utils/most_usage_functions.dart';

class FireBaseAuth extends GetxController {
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

  creatUserWithEmailAndPassword({String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email ?? "", password: password ?? "");
      await snackSuccess('Success', "Done!");
      print("${userCredential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        awesomeDialog(
          Get.context!,
          title: 'Error',
          description: 'the password provided is too weak',
        );
      } else if (e.code == 'email-already-in-use') {
        awesomeDialog(
          Get.context!,
          title: 'Error',
          description: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void loginValid(
      {TextEditingController? email, TextEditingController? password}) {
    String emailText = email!.text;
    String passwordText = password!.text;
    if (emailText.isNotEmpty && passwordText.isNotEmpty) {
      SharedPref.instance.setUserEmail(userEmail: emailText);
      SharedPref.instance.setUserPassword(userPassword: passwordText);
      Logger().e("getUserEmail : ${SharedPref.instance.getUserEmail()}");
      signInWithEmailAndPassword(email: emailText, password: passwordText);
      update();
    }
  }

  Future<void> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      if (!SharedPref.instance.getIsUserLoggedIn()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email ?? "", password: password ?? "");
        await snackSuccess("login Success", "user is signed in");
        await SharedPref.instance.setIsUserLoggedIn(true);
        update();
        await Get.off(const HomePage());
      } else {
        awesomeDialog(Get.context!,
            title: "Sorry",
            description: "user is already signed in",
            dialogType: DialogType.warning);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        awesomeDialog(
          Get.context!,
          title: 'Error',
          description: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        awesomeDialog(
          Get.context!,
          title: 'Error',
          description: 'Wrong password provided for that user.',
        );
      }
    }
    //checkIfUserVerified stooped after test worked well
    // User user = FirebaseAuth.instance.currentUser!;
    // checkIfUserVerified(user);
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
      if (SharedPref.instance.getIsUserLoggedIn()) {
        Logger().e(
            "getIsUserLoggedIn : ${SharedPref.instance.getIsUserLoggedIn()}");
        await FirebaseAuth.instance.signOut();
        await snackSuccess("title", 'user is signed out');
        await SharedPref.instance.setIsUserLoggedIn(false);
        // SharedPref.instance.clear();
        Get.offAll(const LoginScreen());
      } else {
        awesomeDialog(Get.context!,
            title: "Sorry",
            description: "user is already signed out",
            dialogType: DialogType.warning);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await snackSuccess("title", "user is already signed out");
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

/*
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
*/

}
