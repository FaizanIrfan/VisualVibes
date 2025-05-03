import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RateAppDialog extends StatefulWidget {
  const RateAppDialog({super.key});

  @override
  State<RateAppDialog> createState() => _RateAppDialogState();
}

class _RateAppDialogState extends State<RateAppDialog> {
  int _selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          "Rate this App",
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
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity, // Takes full width of dialog
            child: FittedBox(
              fit: BoxFit.scaleDown, // Scales down if needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedStars = index + 1;
                      });
                    },
                    icon: Icon(
                      Icons.star,
                      size: MediaQuery.of(context).size.width *
                          0.08, // Dynamic size
                      color: index < _selectedStars
                          ? Colors.amber
                          : Colors.grey[400],
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 22),
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
                    "Thank you for rating $_selectedStars stars!",
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
