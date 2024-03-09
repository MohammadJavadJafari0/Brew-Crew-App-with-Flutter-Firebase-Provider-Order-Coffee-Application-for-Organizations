import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final String uid;

  Home({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: uid).brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[400],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: const Color.fromARGB(255, 224, 150, 60),
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
        body: const BrewList(), // Use BrewList widget
      ),
    );
  }
}
