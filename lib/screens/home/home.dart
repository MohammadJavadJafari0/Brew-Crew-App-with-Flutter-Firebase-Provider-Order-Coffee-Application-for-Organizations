import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/settings_form.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final String uid;

  Home({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// _showSettingPanel Fuction
    print("Settings panel is being shown!");
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

// Hoome UI
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: uid).brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[400],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: const Color.fromARGB(255, 219, 159, 86),
          elevation: 0.0,
          actions: [
            // Logout Icon
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person),
                label: const Text("Logout"),
              ),
            ),

            // Setting Icon
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  _showSettingsPanel();
                },
                icon: const Icon(Icons.settings),
                label: const Text("Setting"),
              ),
            )
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/coffee_brewcrew_app.png"),
                    fit: BoxFit.cover)),
            child: const BrewList()),
      ),
    );
  }
}
