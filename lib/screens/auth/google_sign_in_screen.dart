import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/repository/google_sign_in_repository.dart';
import 'package:tera_app/utils/assets_manager.dart';

class GoogleSignInScreen extends ConsumerWidget {
  const GoogleSignInScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    User? user =
        await ref.read(googleSignInRepositoryProvider).signInWithGoogle();
    if (user == null) {
      scaffoldMessengerState.showSnackBar(
        const SnackBar(content: Text("An error Occured")),
      );
    } else {
      ref.read(userProvider.notifier).update((state) => user);
      navigator.replace("/");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () {
              signInWithGoogle(ref, context);
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
              final navigator = Routemaster.of(context);
              final res = await ref
                  .watch(googleSignInRepositoryProvider)
                  .signOutWithGoogle();
              if (res == null) {
                navigator.popUntil((routeData) => false);
                navigator.push("/");
              }
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
  }
}
