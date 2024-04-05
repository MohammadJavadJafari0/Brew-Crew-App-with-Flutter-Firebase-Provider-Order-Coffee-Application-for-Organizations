import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/my_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      catchError: (context, error) {
        // Handle the error in StreamProvider
        print('Error occurred in StreamProvider: $error');
        return null; // Return a default value or null if necessary
      },
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(
              255, 19, 17, 17), // Change background color in all screens
          colorScheme: const ColorScheme.dark()
              .copyWith(primary: const Color.fromARGB(255, 224, 150, 60)),
          hintColor: Colors.tealAccent,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
