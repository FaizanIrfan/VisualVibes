import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons/uicons.dart';
import 'package:visual_vibes/screens/privacy_policy.dart';
import 'package:visual_vibes/screens/terms_conditions.dart';
import 'package:visual_vibes/widgets/settings-tab/report_bugs.dart';
import 'package:visual_vibes/widgets/settings-tab/rate_app.dart';
import 'package:visual_vibes/widgets/settings-tab/switch_button.dart';
import 'package:share_plus/share_plus.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        elevation: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.notifications,
                    title: 'Push notifications',
                    trailing: SwitchButton(),
                  ),
                  _buildSettingsTile(
                    icon: Icons.send,
                    title: 'Invite a friend',
                    onTap: () {
                      Share.share(
                          'Check out this amazing Wallpaper app named "Visual Vibes"');
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.star,
                    title: 'Rate this app',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const RateAppDialog(),
                      );
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.feedback,
                    title: 'Report Bugs',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ReportBugs(),
                      );
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.description,
                    title: 'Terms & Conditions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsConditions()),
                      );
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: Icon(UIcons.brands.instagram, size: 30)),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(UIcons.brands.facebook, size: 30)),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(UIcons.brands.twitter, size: 30)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Like & Follow us on',
                  style:
                      GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
      {required IconData icon,
      required String title,
      Widget? trailing,
      VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 24),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
      ),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
      onTap: onTap,
    );
  }
}
