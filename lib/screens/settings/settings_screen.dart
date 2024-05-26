import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _linkController = TextEditingController(text: BASE);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text("Enter Your App Link"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  maxLines: 4,
                  controller: _linkController,
                  onSubmitted: (value) {
                    BASE = value;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  BASE = _linkController.text;
                  BASE_WS = BASE;
                  BASE_URL = "$BASE/api/v1";
                });
                Routemaster.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
