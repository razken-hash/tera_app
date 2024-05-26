import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/screens/auth/google_sign_in_screen.dart';
import 'package:tera_app/screens/editor/editor_screen.dart';
import 'package:tera_app/screens/documents/documents_screen.dart';
import 'package:tera_app/screens/settings/settings_screen.dart';
import 'package:tera_app/screens/collaboration/collaboration_screen.dart';

final RouteMap loggedOutRoutes = RouteMap(routes: {
  "/": (route) => const MaterialPage(
        child: AuthScreen(),
      ),
  "/settings": (route) => const MaterialPage(
        child: SettingsScreen(),
      ),
});

final RouteMap loggedInRoutes = RouteMap(routes: {
  "/home": (route) => const MaterialPage(
        child: DocumentsScreen(),
      ),
  "/docs/:documentId": (route) => MaterialPage(
        child: EditorScreen2(
          documentId: route.pathParameters["documentId"]!,
        ),
      ),
  "/share": (route) => MaterialPage(
        child: ColaborationScreen(),
      ),
});
