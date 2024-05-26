import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tera_app/models/document.dart';
import 'package:tera_app/providers/documents_provider.dart';
import 'package:tera_app/screens/themes/tera_colors.dart';
import 'package:tera_app/services/socket_service.dart';
import 'package:tera_app/utils/assets_manager.dart';
import 'package:clipboard/clipboard.dart';

class EditorScreen extends StatefulWidget {
  final Document document;
  const EditorScreen({super.key, required this.document});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  quill.QuillController? _quillController;

  final TextEditingController _titleController = TextEditingController();

  Document? document;

  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _socketService.joinRoom(widget.document.id);
    loadDocument(widget.document);

    _socketService.listenToChanges((data) {
      _quillController!.compose(
        Delta.fromJson(data["delta"]),
        _quillController!.selection,
        quill.ChangeSource.remote,
      );
    });
  }

  void loadDocument(Document document) async {
    _titleController.text = document.title;
    _quillController = quill.QuillController(
      document: document.content.isEmpty
          ? quill.Document()
          : quill.Document.fromDelta(
              Delta.fromJson(document.content),
            ),
      selection: const TextSelection.collapsed(offset: 0),
    );
    setState(() {});

    _quillController!.document.changes.listen((event) {
      if (event.source == quill.ChangeSource.local) {
        Map<String, dynamic> data = {
          "delta": event.change,
          "room": widget.document.id,
        };
        _socketService.typeText(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _quillController == null
        ? const Center()
        : Consumer<DocumentsProvider>(builder: (context, docsProvider, child) {
            return FutureBuilder<Document?>(
                future: docsProvider.getDocumentById(
                    documentId: widget.document.id),
                builder: (context, snapshot) {
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: 2))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.iconify("docs"),
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.scaleDown,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: _titleController,
                                    onSubmitted: (value) async {
                                      docsProvider.updateDocumentTitle(
                                          documentId: widget.document.id,
                                          title: _titleController.text);
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      filled: false,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    FlutterClipboard.copy(document!.id)
                                        .then((value) => print('copied'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                      horizontal: 10,
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: TeraColors.primaryColor,
                                    ),
                                    child: const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.lock,
                                          color: TeraColors.whiteColor,
                                          size: 20,
                                        ),
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: TeraColors.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          quill.QuillToolbar.simple(
                            configurations:
                                quill.QuillSimpleToolbarConfigurations(
                              controller: _quillController!,
                              sharedConfigurations:
                                  const quill.QuillSharedConfigurations(
                                locale: Locale('de'),
                              ),
                              showClipboardCopy: false,
                              showClipboardCut: false,
                              showClipboardPaste: false,
                              showSearchButton: false,
                              showSuperscript: false,
                              showSubscript: false,
                              showQuote: false,
                              showCodeBlock: false,
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: quill.QuillEditor.basic(
                                  configurations:
                                      quill.QuillEditorConfigurations(
                                    controller: _quillController!,
                                    sharedConfigurations:
                                        const quill.QuillSharedConfigurations(
                                      locale: Locale('de'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          });
  }
}

class EditorScreen2 extends StatelessWidget {
  final String documentId;
  const EditorScreen2({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentsProvider>(
      builder: (context, docsProvider, child) {
        return FutureBuilder<Document?>(
          future: docsProvider.getDocumentById(documentId: documentId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return EditorScreen(
                  document: snapshot.data!,
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        );
      },
    );
  }
}
