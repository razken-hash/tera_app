import 'package:flutter/material.dart';

void main() {
  runApp(const TeraApp());
}

class TeraApp extends StatelessWidget {
  const TeraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Placeholder(),
      debugShowCheckedModeBanner: false,
    );
  }
}
