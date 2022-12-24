import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_Service/firebase_auth.dart';

class AuthMethods extends StatelessWidget {
  const AuthMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCredential? userCredential;
    FireBaseAuth fireBaseAuth = FireBaseAuth();
    // Google Sign-in
    final credential =
        GoogleAuthProvider.credential(idToken: 'WIeN8kTCD1hIjwhrNo57VwQBYCg2)');
    // Email and password sign-in
    final emailPassCredential = EmailAuthProvider.credential(
        email: "mam.farra2030@gmail.com", password: "123456789");

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Testing firebase Auth:',
          ),
          // this Button for anonymous sign in
          ElevatedButton(
              onPressed: () => fireBaseAuth.anonymouseSignIn(userCredential),
              child: const Text("»anonymouse Sign In")),

          ElevatedButton(
            onPressed: () => fireBaseAuth.creatUserWithEmailAndPassword(
                email: "emailTest1@gmail.com", password: "123456789"),
            child: const Text("»creatUserWithEmailAndPassword"),
          ),
          ElevatedButton(
            onPressed: () => fireBaseAuth.signInWithEmailAndPassword(
                email: "emailTest1@gmail.com", password: "123456789"),
            child: const Text("»sign In WithEmailAndPassword"),
          ),
          ElevatedButton(
            onPressed: () => fireBaseAuth.signOut(),
            child: const Text("»sign Out"),
          ),
          ElevatedButton(
            onPressed: () async {
              UserCredential cred = await fireBaseAuth.signInWithGoogle();
              print(cred);
            },
            child: const Text("signInWithGoogle"),
          ),
        ]);
  }
}
