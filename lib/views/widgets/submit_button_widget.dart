import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 112, 1, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          "Submit Job Description",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
