import 'package:provider/provider.dart';
import 'package:tera_app/providers/auth_provider.dart';
import 'package:tera_app/providers/documents_provider.dart';
import 'package:tera_app/providers/editor_provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<EditorProvider>(create: (context) => EditorProvider()),
  ChangeNotifierProvider<DocumentsProvider>(
      create: (context) => DocumentsProvider()),
];
