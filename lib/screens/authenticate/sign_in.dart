import 'package:brew_crew/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // For Anon Firebase Authenticate

  final AuthService _authService = AuthService();
  String email = "";
  String password = "";

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
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Ink(
                width: 95,
                child: ElevatedButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      SizedBox(height: 2),
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                  child: const Text("sign in"))
            ],
          ))),
    );
  }
}
