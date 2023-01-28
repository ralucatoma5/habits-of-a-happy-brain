import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habits/screens/signin.dart';
import 'package:habits/screens/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? SignInScreen(onClickedSignUp: toggle)
        : SignUpScreen(onClickedSignIn: toggle);
  }
}
