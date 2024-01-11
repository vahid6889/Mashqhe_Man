import 'package:flutter/material.dart';
import 'package:mashgh/features/feature_image_worksheet/presentation/screens/test_editor.dart';

class ImageWorksheetPage extends StatelessWidget {
  static const routeName = "/photo_worksheet";
  static int page = 1;
  const ImageWorksheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TestEditor();
  }
}
