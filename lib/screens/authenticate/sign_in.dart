import 'package:brew_crew/models/my_user.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 224, 150, 60),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person),
                            SizedBox(height: 1),
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/cup_a_coffee.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          style: TextStyle(color: userTextColor),
                          validator: (value) =>
                              value!.isEmpty || !validateEmail(email)
                                  ? "Enter a valid Email"
                                  : null,
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          style: TextStyle(color: userTextColor),
                          obscureText: true,
                          validator: (value) => value!.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("valid");
                              setState(() {
                                loading = true; //loading screen
                              });
                              try {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (result == null) {
                                  setState(() => error =
                                      "Could not sign in with those credentials!");
                                  loading = false;
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  setState(() => error =
                                      "Invalid email or password. Please try again.");
                                }
                                loading = false;
                              }
                            }
                          },
                          child: const Text("sign in"),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(fontSize: 14, color: massagesColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
