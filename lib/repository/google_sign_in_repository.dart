// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:html';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tera_app/models/user.dart';

Provider googleSignInRepositoryProvider = Provider(
  (ref) => GoogleSignInRepository(
    googleSignIn: GoogleSignIn(),
  ),
);

class GoogleSignInRepository {
  late GoogleSignIn _googleSignIn;

  GoogleSignInRepository({
    required GoogleSignIn googleSignIn,
  }) {
    _googleSignIn = googleSignIn;
  }

  void signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
    } catch (e) {
      log("An Error");
      log(e.toString());
    }
  }
}
