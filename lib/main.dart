import 'package:flutter/material.dart';
import 'package:social_media_app/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app/theme/Dark_Theme.dart';
import 'package:social_media_app/theme/Light_Theme.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthPage(),
    );
  }
}

