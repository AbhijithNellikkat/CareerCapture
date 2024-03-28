import 'dart:io';

import 'package:career_capture/views/create_new_pdf.dart';
import 'package:career_capture/views/pdfPreview_view.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
      // body: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2),
      //     itemCount: 5,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(5.0),
      //         child: Card(
      //           elevation: 3,
      //           child: Container(
      //             width: double.infinity,
      //             height: 300,
      //             decoration: const BoxDecoration(
      //               borderRadius: BorderRadius.all(Radius.circular(10)),
      //               image: DecorationImage(
      //                 image: AssetImage('assets/images/pdf_image.png'),
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: FutureBuilder<List<String>>(
        future: _listPdfFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pdfPaths = snapshot.data ?? [];
            return ListView.builder(
              itemCount: pdfPaths.length,
              itemBuilder: (context, index) {
                final pdfPath = pdfPaths[index];
                return ListTile(
                  title: Text('Job Description ${index + 1}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewPage(pdfPath: pdfPath),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateNewPdfView(),
            ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

Future<List<String>> _listPdfFiles() async {
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
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
    return [];
  }
}
