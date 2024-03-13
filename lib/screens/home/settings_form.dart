import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

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
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const Text(
            "unpdate your brew settings.",
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20),
          TextFormField(
              decoration: textInputDecoration,
              style: const TextStyle(color: Colors.black),
              validator: (value) =>
                  value!.isEmpty ? "Please enter a name" : null,
              onChanged: (value) => setState(() {
                    _currentName = value;
                  })),
          const SizedBox(
            height: 20.0,
          ),
          // DropDown
          DropdownButtonFormField(
            dropdownColor: const Color(0xFFFFCC80),
            decoration: textInputDecoration,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            value: _currentSugars ?? "0",
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
          // Slider
          Slider(
            value: (_currentStrength ?? 100).toDouble(),
            onChanged: (value) => setState(() {
              _currentStrength = value.round();
            }),
            min: 100.0,
            max: 900.0,
            divisions: 8,
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.white,
          ),

          //update Button
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 224, 150, 60)),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              },
              child: const Text(
                "update",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
