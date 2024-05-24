import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/document.dart';
import 'package:tera_app/repository/document_repository.dart';
import 'package:tera_app/repository/google_sign_in_repository.dart';
import 'package:tera_app/screens/auth/google_sign_in_screen.dart';
import 'package:tera_app/utils/assets_manager.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void logout(WidgetRef ref, BuildContext context) async {
    final navigator = Routemaster.of(context);
    bool res =
        await ref.watch(googleSignInRepositoryProvider).signOutWithGoogle();
    ref.watch(userProvider.notifier).update(
          (state) => null,
        );
    if (res) {
      navigator.popUntil((routeData) => false);
      navigator.push("/");
    }
  }

  void createDocument(
    BuildContext context,
    WidgetRef ref,
  ) async {
    String token = ref.watch(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackBar = ScaffoldMessenger.of(context);
    Document? document =
        await ref.watch(documentRepositoryProvider).createDocument(token);
    log(document.toString());
    if (document != null) {
      navigator.push("/docs/${document.id}");
    } else {
      snackBar.showSnackBar(
        const SnackBar(
          content: Text("An error occured"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "TeraApp",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () async {
                  logout(ref, context);
                },
                icon: SvgPicture.asset(
                  AssetsManager.iconify(
                    "google",
                  ),
                  height: 30,
                ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Docs:",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    createDocument(context, ref);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.5,
                children: List.generate(
                  17,
                  (index) => SizedBox(
                    height: 100,
                    child: Container(
                      // height: 170,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManager.iconify(index % 3 == 0
                                    ? "docs"
                                    : index % 3 == 1
                                        ? "sheets"
                                        : "slides"),
                                height: 50,
                                width: 50,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: 5),
                              const Expanded(
                                  child: Text("Report2023/2024.docx")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("10.Nov.2024"),
                              InkWell(
                                onTap: () {
                                  final navigator = Routemaster.of(context);
                                  navigator.push("/docs");
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.blueAccent,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
