import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DocScreen extends StatelessWidget {
//   final String documentId;
//   DocScreen({super.key, required this.documentId});
//   final QuillController _controller = QuillController.basic();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               QuillToolbar.simple(
//                 configurations: QuillSimpleToolbarConfigurations(
//                   controller: _controller,
//                   sharedConfigurations: const QuillSharedConfigurations(
//                     locale: Locale('de'),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: QuillEditor.basic(
//                   configurations: QuillEditorConfigurations(
//                     controller: _controller,
//                     // readOnly: false,
//                     sharedConfigurations: const QuillSharedConfigurations(
//                       locale: Locale('de'),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }

class DocumentScreen extends ConsumerStatefulWidget {
  final String documentId;

  const DocumentScreen({super.key, required this.documentId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.documentId,
        ),
      ),
    );
  }
}
