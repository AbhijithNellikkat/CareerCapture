// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewPage({Key? key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: PDFView(
          // nightMode: true,
          filePath: pdfPath,

        ),
      ),
    );
  }
}
