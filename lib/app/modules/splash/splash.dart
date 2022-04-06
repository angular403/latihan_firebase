import 'package:flutter/material.dart';

class SplashCreen extends StatelessWidget {
  const SplashCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.green),
        ),
      ),
    );
  }
}
