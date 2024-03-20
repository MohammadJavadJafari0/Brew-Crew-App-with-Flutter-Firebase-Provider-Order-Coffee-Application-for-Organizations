import 'package:brew_crew/models/my_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key});

  @override
  State<SettingsForm> createState() => _SettingsFromState();
}

class _SettingsFromState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData? userdata = snapshot.data;
        return Form(
          key: _formkey,
          child: Column(
            children: [
              const Text(
                "Update your brew settings.",
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: userdata?.name,
                decoration: textInputDecoration,
                style: const TextStyle(color: Colors.black),
                validator: (value) =>
                    value!.isEmpty ? "Please enter a name" : null,
                onChanged: (value) => setState(() {
                  _currentName = value;
                }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                dropdownColor: const Color(0xFFFFCC80),
                decoration: textInputDecoration,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                value: _currentSugars ?? userdata?.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text(
                      '$sugar sugars',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentSugars = value;
                  });
                },
              ),
              Slider(
                value:
                    (_currentStrength ?? userdata?.strength ?? 100).toDouble(),
                onChanged: (value) => setState(() {
                  _currentStrength = value.round();
                }),
                min: 100.0,
                max: 900.0,
                divisions: 8,
                activeColor:
                    Colors.brown[_currentStrength ?? userdata?.strength ?? 100],
                inactiveColor: Colors.white,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 224, 150, 60),
                ),
                onPressed: () async {
                  print("_currentName: $_currentName");
                  print("_currentSugars: $_currentSugars");
                  print("_currentStrength: $_currentStrength");
                  if (_formkey.currentState!.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userdata!.sugars,
                        _currentName ?? userdata!.name,
                        _currentStrength ?? userdata!.strength);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
