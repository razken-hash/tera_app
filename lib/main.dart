import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tera_app/screens/auth/google_sign_in_screen.dart';

void main() {
  runApp(const TeraApp());
}

class TeraApp extends StatefulWidget {
  const TeraApp({super.key});

  @override
  State<TeraApp> createState() => _TeraAppState();
}

class _TeraAppState extends State<TeraApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: GoogleSignInScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
