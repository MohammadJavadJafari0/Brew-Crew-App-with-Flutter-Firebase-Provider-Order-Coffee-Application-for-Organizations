import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 19, 17, 17),
      child: const Align(
        alignment: Alignment.center,
        child: SpinKitChasingDots(
            color: Color.fromARGB(255, 164, 133, 122), size: 50),
      ),
    );
  }
}
