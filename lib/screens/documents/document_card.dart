import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tera_app/models/document.dart';
import 'package:tera_app/utils/assets_manager.dart';

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
