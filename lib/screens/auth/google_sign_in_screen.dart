import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/providers/auth_provider.dart';
import 'package:tera_app/utils/assets_manager.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Routemaster.of(context).push("/settings");
          },
          child: const Icon(
            Icons.settings,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Welcome to Tera App",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            TextButton.icon(
              onPressed: () async {
                User? user = await authProvider.signInWithGoogle();
                if (user != null) {
                  Routemaster.of(context).replace("/home");
                }
                // TODO: Sign in with google
              },
              icon: SvgPicture.asset(
                AssetsManager.iconify(
                  "google",
                ),
                height: 30,
              ),
              label: const Text(
                "Sign In With Google",
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            TextButton.icon(
              onPressed: () async {
                authProvider.signOutWithGoogle();
                //TODO: Sign in with google
              },
              icon: SvgPicture.asset(
                AssetsManager.iconify(
                  "google",
                ),
                height: 30,
              ),
              label: const Text(
                "Sign Out",
              ),
            ),
          ],
        ),
      );
    });
  }
}
