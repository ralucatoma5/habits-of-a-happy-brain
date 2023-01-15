import 'package:flutter/material.dart';
import 'package:habits/components/background_signup.dart';
import 'package:habits/const.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: blue,
      body: BackgroundSignUp(
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
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: pink),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 3, color: pink),
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(color: pink)),
              ),
            ),
            SizedBox(
              height: verticalBlock * 2.5,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: pink),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 3, color: pink),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: pink)),
                obscureText: true,
              ),
            ),
            SizedBox(height: verticalBlock * 15),
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
              onPressed: () {},
              child: Text(
                'Sign up',
                style: TextStyle(
                    color: blue,
                    fontWeight: FontWeight.bold,
                    fontSize: verticalBlock * 2.3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
