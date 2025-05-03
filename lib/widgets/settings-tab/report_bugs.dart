import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportBugs extends StatelessWidget {
  const ReportBugs({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          "Report Bugs",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: feedbackController,
            maxLines: 3,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.grey[200],
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.5), // Black border when focused
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "We've received your report!",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  backgroundColor: Color.fromARGB(255, 64, 142, 144),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              "Submit",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
