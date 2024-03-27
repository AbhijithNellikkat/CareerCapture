import 'package:career_capture/views/create_new_pdf.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 112, 1, 1),
                    ),
                    left: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 112, 1, 1),
                    ),
                    right: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 112, 1, 1),
                    ),
                    top: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 112, 1, 1),
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/pdf_image.png'),
                  ),
                ),
              ),
            );
          },
        ),
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
