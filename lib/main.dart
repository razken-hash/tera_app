import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/providers/auth_provider.dart';
import 'package:tera_app/screens/providers/providers.dart';

import 'package:tera_app/screens/routers/routers.dart';
import 'package:tera_app/screens/themes/themes.dart';

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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
            User? u;
            authProvider.getUserData().then((value) {
              u = value;
            });
            if (u == null) {
              return loggedOutRoutes;
            }
            return loggedInRoutes;
          }),
          routeInformationParser: const RoutemasterParser(),
        );
      }),
    );
  }
}
