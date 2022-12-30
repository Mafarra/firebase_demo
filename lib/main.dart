// ignore_for_file: avoid_print

import 'package:firebase_demo/Utils/sh_util.dart';
import 'package:firebase_demo/presentation/auth/login_screen.dart';
import 'package:firebase_demo/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool _isUserloggedIn = SharedPref.instance.getIsUserLoggedIn();
    return GetMaterialApp(  
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isUserloggedIn
          ? const HomePage()
          : const LoginScreen(),
    );
  }
}
