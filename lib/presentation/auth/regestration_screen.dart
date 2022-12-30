// ignore_for_file: unused_field
import 'package:firebase_demo/viewModel/firebase_auth.dart';
import 'package:firebase_demo/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/simple_custom_text_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _email;
  String? _password;
  bool _isObsecure = true;
  FireBaseAuth fireBaseAuth = FireBaseAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: Column(
          children: [
            Image.asset(
              'assets/todo_logo.png',
              width: 200,
              height: 200,
            ),
            registrationForm(),
          ],
        ));
  }

  Form registrationForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        child: Column(
          children: [
            CustomTextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "username",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: 'Username',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              onSaved: (value) => _username = value,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              onSaved: (value) => _email = value,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: _isObsecure
                      ? const Icon(Icons.visibility_off)
                      : const Icon(
                          Icons.visibility,
                        ),
                  onPressed: () {
                    setState(() {
                      _isObsecure = !_isObsecure;
                    });
                  },
                ),
                hintText: "Password",
                border:
                    const OutlineInputBorder(borderSide: BorderSide(width: 1)),
              ),
              obscureText: _isObsecure,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              onSaved: (value) => _password = value,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Text('if you have an Account'),
                TextButton(
                  onPressed: () {
                    Get.to(const LoginScreen());
                  },
                  child: const Text(' Click Here'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await signUp();
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  signUp() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      fireBaseAuth.creatUserWithEmailAndPassword(
          email: _email, password: _password);
    }
  }
}
