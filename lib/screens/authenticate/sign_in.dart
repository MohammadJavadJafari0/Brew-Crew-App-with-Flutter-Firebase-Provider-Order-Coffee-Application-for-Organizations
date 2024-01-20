import 'package:brew_crew/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // For Anon Firebase Authenticate

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE69D45),
        elevation: 0.0,
        title: const Text(
          "Sign in Brew Crew",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await _authService.signInAnon();
            if (result == null) {
              print("error singing in");
            } else {
              print("signed in");
              print(result);
              print('User ID: ${result.uid}');
            }
          },
          child: const Text("Sign In Anon"),
        ),
      ),
    );
  }
}
