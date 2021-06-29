import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.blueGrey,
        accentColor: Colors.deepOrangeAccent,
        accentColorBrightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: Colors.deepOrangeAccent,
            onPrimary: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.deepOrangeAccent,
          ),
        ),
      ),
      home: AuthScreen(),
    );
  }
}
