import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
         print('user is signed in');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  UserCredential? userCredential;
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
                  onPressed: () => anonymouseSignIn(userCredential),
                  child: const Text("»anonymouse Sign In")),

              ElevatedButton(
                onPressed: () => creatUserWithEmailAndPassword(userCredential),
                child: const Text("»creatUserWithEmailAndPassword"),
              ),
              ElevatedButton(
                onPressed: () => signInWithEmailAndPassword(userCredential),
                child: const Text("»sign In WithEmailAndPassword"),
              ),
            ]),
      ),
    );
  }
}
