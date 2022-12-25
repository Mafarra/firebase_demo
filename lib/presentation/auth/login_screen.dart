import 'package:firebase_demo/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../firebase_Service/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _isObsecure = true;
  FireBaseAuth fireBaseAuth = FireBaseAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: loginForm());
  }

  Form loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "email",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: 'email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
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
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('sign in'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                fireBaseAuth.signOut();
              },
              child: const Text('sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform login here
      fireBaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);
    }
  }
}
