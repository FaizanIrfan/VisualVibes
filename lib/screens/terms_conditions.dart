import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_vibes/widgets/custom_appbar.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: CustomAppBar(title: 'Terms & Conditions'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "By using the Visual Vibes app, you agree to comply with the following terms and conditions:",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 18),
              _buildTerm("By accessing and using Visual Vibes, you acknowledge that you have read, understood, and agreed to these terms. If you do not agree, please refrain from using the app."),
              const SizedBox(height: 9),
              _buildTerm("All wallpapers provided in the app are for personal use only. You may download and set them as your wallpaper but cannot use them for commercial purposes."),
              const SizedBox(height: 9),
              _buildTerm("You are strictly prohibited from redistributing, modifying, reselling, or using the wallpapers for any commercial purpose without explicit permission from the app developers or copyright holders."),
              const SizedBox(height: 9),
              _buildTerm("Visual Vibes may update these terms from time to time. Continued use of the app after modifications signifies your acceptance of the updated terms. We encourage you to review this page periodically."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTerm(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
