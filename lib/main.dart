import 'package:flutter/material.dart';
import 'package:tera_app/screens/auth/google_sign_in_screen.dart';

void main() {
  runApp(const TeraApp());
}

class TeraApp extends StatelessWidget {
  const TeraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GoogleSignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
