import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_vibes/widgets/custom_appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: CustomAppBar(title: 'Privacy Policy'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "At Visual Vibes, we are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and protect your information while you use our app.",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 18),
              _buildTerm("We collect minimal user data solely for the purpose of improving the app experience. This may include non-personal information such as device type, app usage patterns, and crash reports."),
              const SizedBox(height: 9),
              _buildTerm("Your data is never shared with third parties. We do not sell, trade, or transfer your personal information to external entities."),
              const SizedBox(height: 9),
              _buildTerm("The app may collect anonymous usage analytics to enhance features, optimize performance, and deliver a better user experience. This data does not include personally identifiable information."),
              const SizedBox(height: 9),
              _buildTerm("If you wish to delete your data, you can do so by simply uninstalling the app. No personally identifiable data is retained after uninstallation."),
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
