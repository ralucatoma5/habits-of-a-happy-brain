import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habits/firebase_options.dart';
import 'package:habits/screens/healthyhabits_screen.dart';
import 'package:habits/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habbits of a Happy Brain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff005489),
        scaffoldBackgroundColor: const Color(0xffFEFEFE),
      ),
      home: HomeScreen(),
    );
  }
}
