import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('sign out'),
        onPressed: () => FirebaseAuth.instance.signOut(),
      ),
    );
  }
}
