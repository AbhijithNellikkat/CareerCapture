// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:io';

import 'package:career_capture/views/create_new_pdf.dart';
import 'package:career_capture/views/pdfPreview_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<String> pdfPaths;

  @override
  void initState() {
    super.initState();
    _loadPdfFiles();
  }

  void _loadPdfFiles() async {
    try {
      final List<String> files = await _listPdfFiles();
      setState(() {
        pdfPaths = files;
      });
    } catch (e) {
      debugPrint('Error loading PDF files: $e');
      setState(() {
        pdfPaths = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Career Capture',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 112, 1, 1),
      ),
      body: _buildPdfGridView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPdfPath = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNewPdfView(),
          ));

          if (newPdfPath != null) {
            setState(() {
              pdfPaths.add(newPdfPath);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPdfGridView() {
    if (pdfPaths.isEmpty) {
      return const Center(child: Text('No PDFs found'));
    } else {
      return Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: pdfPaths.length,
            itemBuilder: (context, index) {
              final pdfPath = pdfPaths[index];
              final file = File(pdfPath);
              final creationDate = file.lastModifiedSync();
              final formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(creationDate);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewPage(pdfPath: pdfPath),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset(
                            'assets/images/pdf_image.png',
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Created: $formattedDate',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Future<List<String>> _listPdfFiles() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final List<FileSystemEntity> files = directory.listSync();
      final List<String> pdfPaths = [];
      for (var file in files) {
        if (file.path.endsWith('.pdf')) {
          pdfPaths.add(file.path);
        }
      }
      return pdfPaths;
    } catch (e) {
      debugPrint('Error listing PDF files: $e');
      rethrow;
    }
  }
}
