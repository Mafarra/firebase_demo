// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_Service/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserCredential? userCredential;
  FireBaseAuth fireBaseAuth = FireBaseAuth();
  // Google Sign-in
  final credential =
      GoogleAuthProvider.credential(idToken: 'WIeN8kTCD1hIjwhrNo57VwQBYCg2)');
  // Email and password sign-in
  final emailPassCredential = EmailAuthProvider.credential(
      email: "mam.farra2030@gmail.com", password: "123456789");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Testing firebase Auth:',
              ),
              // this Button for anonymous sign in
              ElevatedButton(
                  onPressed: () =>
                      fireBaseAuth.anonymouseSignIn(userCredential),
                  child: const Text("»anonymouse Sign In")),

              ElevatedButton(
                onPressed: () =>
                    fireBaseAuth.creatUserWithEmailAndPassword(userCredential),
                child: const Text("»creatUserWithEmailAndPassword"),
              ),
              ElevatedButton(
                onPressed: () =>
                    fireBaseAuth.signInWithEmailAndPassword(userCredential),
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
            ]),
      ),
    );
  }
}
