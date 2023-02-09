import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/background_signin.dart';
import '../const.dart';
import '../main.dart';
import 'forgotpass_screen.dart';
import 'signup.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  SignInScreen({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool pass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signinError() {
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
      body: SingleChildScrollView(
        child: BackgroundSignIn(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(
                    color: blue,
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
                height: verticalBlock * 23,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),
              ),
              SizedBox(
                height: verticalBlock * 2.5,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: verticalBlock * 3),
              pass == false
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: horizontalBlock * 10),
                        child: Text('Incorrect username or password',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: verticalBlock * 2)),
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen()),
                ),
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                      left: horizontalBlock * 10,
                      right: horizontalBlock * 10,
                      bottom: verticalBlock * 4,
                      top: verticalBlock * 4),
                  child: Text("Forgot your password?",
                      style: TextStyle(
                          color: blue,
                          fontSize: verticalBlock * 2,
                          decoration: TextDecoration.underline)),
                ),
              ),
              SizedBox(height: verticalBlock * 0.3),
              GestureDetector(
                onTap: signIn,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalBlock * 12,
                      vertical: verticalBlock * 2),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          blue2,
                          pink,
                        ],
                      ),
                      boxShadow: [buttonShadow]),
                  margin:
                      EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                  child: Text("Sign in",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: verticalBlock * 2.3)),
                ),
              ),
              SizedBox(height: verticalBlock * 3.5),
              RichText(
                  text: TextSpan(
                      text: "Don't have an accout?  ",
                      style: TextStyle(
                          color: Colors.black, fontSize: verticalBlock * 1.8),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: "Sign up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: blue,
                            fontSize: verticalBlock * 2))
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      signinError();
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
