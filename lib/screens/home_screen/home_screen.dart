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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routemaster.of(context).push("/share");
        },
        child: const Icon(
          Icons.edit_document,
        ),
      ),
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
              child: FutureBuilder<List<Document>>(
                future: ref
                    .watch(documentRepositoryProvider)
                    .getDocuments(ref.watch(userProvider).token),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<Document> docs = snapshot.data!;
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.5,
                        children: List.generate(
                          docs.length,
                          (index) => DocumentCard(
                            document: docs[index],
                          ),
                        ),
                      );

                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentCard extends StatelessWidget {
  final Document document;
  const DocumentCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
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
                  AssetsManager.iconify("docs"),
                  height: 50,
                  width: 50,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(width: 5),
                Expanded(child: Text(document.title)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${document.createdAt.day.toString().padLeft(2, "0")}-${document.createdAt.month.toString().padLeft(2, "0")}-${document.createdAt.year}"),
                InkWell(
                  onTap: () {
                    final navigator = Routemaster.of(context);
                    navigator.push("/docs/${document.id}");
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
    );
  }
}
