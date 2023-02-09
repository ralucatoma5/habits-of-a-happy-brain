import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/background_signup.dart';
import '../const.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;
  SignUpScreen({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool pass = true;
  void signUpError() {
    setState(() {
      pass = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final verticalBlock = SizeConfig.safeBlockVertical!;
    final horizontalBlock = SizeConfig.safeBlockHorizontal!;
    return Scaffold(
        backgroundColor: blue,
        body: SingleChildScrollView(
          child: BackgroundSignUp(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: pink,
                        fontSize: verticalBlock * 5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: verticalBlock * 1.5,
                  ),
                  Text('TO CONTINUE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalBlock * 3,
                          letterSpacing: 4)),
                  SizedBox(
                    height: verticalBlock * 17,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: pink),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3, color: pink),
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(color: pink)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          (email != null && !EmailValidator.validate(email))
                              ? 'Enter a valid email'
                              : null,
                    ),
                  ),
                  SizedBox(
                    height: verticalBlock * 2.5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                    child: TextFormField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: pink),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3, color: pink),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: pink)),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ((value) => value != null && value.length < 6
                          ? 'Enter in. 6 characters'
                          : null),
                    ),
                  ),
                  SizedBox(
                    height: verticalBlock * 2.5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: pink),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3, color: pink),
                          ),
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: pink)),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ((value) =>
                          value != passwordController.text.trim()
                              ? 'wrong'
                              : null),
                    ),
                  ),
                  SizedBox(height: verticalBlock * 3),
                  pass == false
                      ? Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: horizontalBlock * 10),
                            child: Text(
                                'This email adress is already in use by another account',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: verticalBlock * 2)),
                          ),
                        )
                      : Text(''),
                  SizedBox(height: verticalBlock * 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalBlock * 12,
                          vertical: verticalBlock * 2),
                    ),
                    onPressed: signUp,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: blue,
                          fontWeight: FontWeight.bold,
                          fontSize: verticalBlock * 2.3),
                    ),
                  ),
                  SizedBox(height: verticalBlock * 3.5),
                  RichText(
                      text: TextSpan(
                          text: "Already have an accout?  ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: verticalBlock * 1.8),
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: "Sign in",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: pink,
                                fontSize: verticalBlock * 2))
                      ])),
                ],
              ),
            ),
          ),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      signUpError();
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
