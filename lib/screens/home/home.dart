import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400], // Change background color
      appBar: AppBar(
        title: const Text("Brew Crew"),
        backgroundColor: const Color.fromARGB(255, 224, 150, 60),
        elevation: 0.0,
        actions: [
          ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text("Logout"))
        ],
      ),
    );
  }
}
