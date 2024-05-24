import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/repository/google_sign_in_repository.dart';
import 'package:tera_app/screens/auth/google_sign_in_screen.dart';
import 'package:tera_app/screens/home_screen/home_screen.dart';
import 'package:tera_app/screens/routers/routers.dart';
import 'package:tera_app/screens/themes/themes.dart';

void main() {
  runApp(const ProviderScope(child: TeraApp()));
}

class TeraApp extends ConsumerStatefulWidget {
  const TeraApp({super.key});

  @override
  ConsumerState<TeraApp> createState() => _TeraAppState();
}

class _TeraAppState extends ConsumerState<TeraApp> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    User? user = await ref.read(googleSignInRepositoryProvider).getUserData();
    if (user != null) {
      ref.read(userProvider.notifier).update((state) => user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        final user = ref.watch(userProvider);
        if (user == null) {
          return loggedOutRoutes;
        }
        return loggedInRoutes;
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
