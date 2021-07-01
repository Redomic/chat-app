import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future<void> _submitAuthForm(
      String email,
      String password,
      String username,
      bool isLogin,
    ) async {
      UserCredential authResult;
      try {
        if (isLogin) {
          authResult = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } else {
          authResult = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      } on FirebaseAuthException catch (error) {
        var message = 'An error occurred, please check credentials!';

        if (error.message != null) {
          message = error.message!;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
      body: AuthForm(_submitAuthForm),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
