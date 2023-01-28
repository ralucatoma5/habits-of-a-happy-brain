import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../const.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool sent = false;
  bool error = false;
  void sentEmail(int v) {
    setState(() {
      error = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: blue, //OR Colors.red or whatever you want
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 11),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Reset your password',
                    style: TextStyle(
                        color: blue,
                        fontSize: verticalBlock * 5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: verticalBlock * 4),
                  Text(
                      textAlign: TextAlign.center,
                      'Please enter your email adress and we will send you a link to reset your password',
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 95, 95),
                        fontSize: verticalBlock * 2,
                      )),
                  SizedBox(height: verticalBlock * 10),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        (email != null && !EmailValidator.validate(email))
                            ? 'Enter a valid email'
                            : null,
                  ),
                  SizedBox(height: verticalBlock * 25),
                  GestureDetector(
                    onTap: resetPassword,
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
                      child: Text("Reset password",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: verticalBlock * 2.3)),
                    ),
                  ),
                  (error == true)
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: verticalBlock * 7),
                          child: Text('An error occured!',
                              style: TextStyle(
                                  fontSize: verticalBlock * 2.3,
                                  color: blue,
                                  fontWeight: FontWeight.w600)))
                      : const Text(''),
                ]),
          ),
        ));
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      sentEmail(2);
      Navigator.of(context).pop;
    }
  }
}
