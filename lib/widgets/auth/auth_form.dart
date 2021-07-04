import 'package:flutter/material.dart';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(
    String email,
    String password,
    String username,
    bool isLogin,
    bool setDetails,
  ) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  var _isLoading = false;

  // User Info
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  bool _setDetails() {
    if (_isLogin) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    void _trySubmit() async {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState!.save();
        setState(() {
          _isLoading = true;
        });
        await widget.submitFn(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
          _isLogin,
          _setDetails(),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.all(20),
        child: _isLoading
            ? Container(
                height: 300,
                width: 300,
                child: Center(
                  child: Container(
                    height: 299,
                    width: 299,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        _isLogin
                            ? Text(
                                'Logging in',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              )
                            : Text(
                                'Signing up',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                      ],
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin) UserImagePicker(),
                        TextFormField(
                          key: ValueKey('email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid Email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userEmail = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                          ),
                        ),
                        if (!_isLogin)
                          TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Enter a username longer than 4 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userName = value!;
                            },
                            decoration: InputDecoration(labelText: 'Username'),
                          ),
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Enter a password longer than 6 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userPassword = value!;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'Already have an account?'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
