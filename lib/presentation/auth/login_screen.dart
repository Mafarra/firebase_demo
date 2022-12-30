import 'package:firebase_demo/Utils/sh_util.dart';
import 'package:flutter/material.dart';
import '../../Utils/app_color.dart';
import '../../Utils/app_strings.dart';
import '../../viewModel/firebase_auth.dart';
import '../widgets/custom_text_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordConroller = TextEditingController();
  FireBaseAuth fireBaseAuth = FireBaseAuth();
  // String _emailText = "";
  // String _passwordText = "";
  @override
  void initState() {
    super.initState();
    emailController!.text = SharedPref.instance.getUserEmail();
    passwordConroller!.text = SharedPref.instance.getUserPassword();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordConroller!.dispose();
    super.dispose();
  }

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
            CustomTextFormFiled(
              label: AppStrings.email,
              keyboardType: TextInputType.emailAddress,
              fillColor: AppColor.userPrimaryCompany,
              cursorColor: AppColor.userPrimaryCompany,
              textInputAction: TextInputAction.next,
              isSmallPaddingWidth: true,
              isBorder: true,
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFiled(
              label: AppStrings.password,
              keyboardType: TextInputType.visiblePassword,
              fillColor: AppColor.userPrimaryCompany,
              cursorColor: AppColor.userPrimaryCompany,
              textInputAction: TextInputAction.done,
              isSmallPaddingWidth: true,
              isBorder: true,
              controller: passwordConroller,
              obscureText: true,
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
          ],
        ),
      ),
    );
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      fireBaseAuth.loginValid(
          email: emailController, password: passwordConroller);
    }
  }
}
