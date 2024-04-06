import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF8D6E63),
      child: const Align(
        alignment: Alignment.center,
        child: SpinKitChasingDots(color: Color(0xFFE69D45), size: 50),
      ),
    );
  }
}
