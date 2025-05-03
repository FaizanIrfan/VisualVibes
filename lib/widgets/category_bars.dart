import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_vibes/screens/view_catgeory.dart';

class CategoryBars extends StatelessWidget {
  final String name;
  final String image;
  final double blur;
  final bool decision;

  const CategoryBars(
      {super.key, required this.name,
      required this.image,
      required this.blur,
      required this.decision});

  @override
  Widget build(BuildContext context) {
    String title = name;
    String path = image;
    final overlay = blur;

    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ViewCategory(name: name))),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: decision == false
            ? MediaQuery.of(context).size.height * 0.08
            : MediaQuery.of(context).size.height * 0.02,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.cover, // Adjust the image to cover the container
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // Semi-transparent black overlay
            Container(
              decoration: BoxDecoration(
                color:
                    Colors.black.withValues(alpha: overlay), // Darker overlay
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Centered text
            Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: decision == false ? 12 : 15,
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black87,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
