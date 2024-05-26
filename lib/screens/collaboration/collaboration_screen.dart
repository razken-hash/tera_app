import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/utils/assets_manager.dart';

class ColaborationScreen extends StatelessWidget {
  ColaborationScreen({
    super.key,
  });
  final TextEditingController _docIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Enter The Id of The Document",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 90,
              child: TextFormField(
                controller: _docIdController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champs est obligatoire";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Doc Id",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      AssetsManager.iconify("docs"),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Routemaster.of(context).push("/docs/${_docIdController.text}");
              },
              child: const Center(
                child: Text("Collaborate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
