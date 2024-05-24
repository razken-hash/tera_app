import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/screens/auth/google_sign_in_screen.dart';
import 'package:tera_app/screens/doc_screen/doc_screen.dart';
import 'package:tera_app/screens/home_screen/home_screen.dart';

final RouteMap loggedOutRoutes = RouteMap(routes: {
  "/": (route) => const MaterialPage(
        child: GoogleSignInScreen(),
      ),
});

final RouteMap loggedInRoutes = RouteMap(routes: {
  "/": (route) => const MaterialPage(
        child: HomeScreen(),
      ),
  "/docs/:documentId": (route) => MaterialPage(
        child: DocumentScreen(
          documentId: route.pathParameters["documentId"]!,
        ),
      ),
});
