import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/document.dart';
import 'package:tera_app/providers/documents_provider.dart';
import 'package:tera_app/providers/auth_provider.dart';
import 'package:tera_app/screens/documents/document_card.dart';
import 'package:tera_app/utils/assets_manager.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Consumer<DocumentsProvider>(
          builder: (context, docsProvider, child) {
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
                      bool res = await authProvider.signOutWithGoogle();
                      if (res) {
                        Routemaster.of(context).popUntil((routeData) => false);
                        Routemaster.of(context).push("/");
                      }
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
                        Document? document =
                            await docsProvider.createDocument();
                        Routemaster.of(context).push("/docs/${document!.id}");
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
                    future: docsProvider.getAllDocuments(),
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
      });
    });
  }
}
