import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/components/background_signin.dart';
import 'package:habits/const.dart';

import 'signup.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgroundSignIn(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: verticalBlock * 13,
            ),
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
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  left: horizontalBlock * 10,
                  right: horizontalBlock * 10,
                  bottom: verticalBlock * 6,
                  top: verticalBlock * 4),
              child: Text("Forgot your password?",
                  style: TextStyle(color: blue, fontSize: verticalBlock * 2)),
            ),
            SizedBox(height: verticalBlock * 0.3),
            GestureDetector(
              onTap: () => {},
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
                margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                child: Text("Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: verticalBlock * 2.3)),
              ),
            ),
            SizedBox(height: verticalBlock * 3.5),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              ),
              child: const Text("Don't have an accout? Sign up"),
            ),
          ],
        ),
      ),
    );
  }

  /*Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }*/
}
