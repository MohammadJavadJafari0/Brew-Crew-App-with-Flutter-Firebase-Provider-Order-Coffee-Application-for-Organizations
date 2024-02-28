import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //for text field
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE69D45),
        elevation: 0.0,
        title: const Text(
          "Sign up Brew Crew",
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
                        'Sign In',
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
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 224, 150, 60)),
                    validator: (value) =>
                        value!.isEmpty ? "Enter a Email" : null,
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print(email);
                        print(password);
                        dynamic result = await _authService
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() => error = "Please supply a valid email");
                        }
                      }
                    },
                    child: const Text("register"),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(fontSize: 14, color: massagesColor),
                  )
                ],
              ))),
    );
  }
}
