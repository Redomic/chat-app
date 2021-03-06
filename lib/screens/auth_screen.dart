import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

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
      File? image,
      bool isLogin,
      bool setDetails,
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

        if (image != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_image')
              .child('${authResult.user!.uid}.jpg');

          await ref.putFile(image);

          final url = await ref.getDownloadURL();

          if (setDetails) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authResult.user!.uid)
                .set({
              'username': username,
              'email': email,
              'image_url': url,
            });
          }
        }
        // if (setDetails) {
        //   await FirebaseFirestore.instance
        //       .collection('users')
        //       .doc(authResult.user!.uid)
        //       .set({
        //     'username': username,
        //     'email': email,
        //     'image_url': url,
        //   });
        // }
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
