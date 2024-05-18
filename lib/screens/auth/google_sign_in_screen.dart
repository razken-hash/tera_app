import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tera_app/repository/google_sign_in_repository.dart';
import 'package:tera_app/utils/assets_manager.dart';

class GoogleSignInScreen extends ConsumerWidget {
  const GoogleSignInScreen({super.key});

  void signInWithGoogle(WidgetRef ref) {
    ref.read(googleSignInRepositoryProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
            onPressed: () {
              signInWithGoogle(ref);
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
          )
        ],
      ),
    );
  }
}
