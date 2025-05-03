import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:uicons/uicons.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';
import 'package:http/http.dart' as http;

class SettingWall extends StatelessWidget {
  final Map<String, dynamic> wallpaper;
  const SettingWall({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showWallpaperBottomSheet(context);
        },
        icon: Icon(
          UIcons.regularStraight.paint_roller,
          size: 25,
          color: Colors.black,
        ));
  }

  void showWallpaperBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "What would you like to do?",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              ListTile(
                  leading: Icon(Icons.home, size: 22, color: Colors.black),
                  title: Text(
                    "Set on home screen",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  onTap: () => setWallpaper(1, context)),
              ListTile(
                  leading: Icon(Icons.lock, size: 22, color: Colors.black),
                  title: Text(
                    "Set on lock screen",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  onTap: () => setWallpaper(2, context)),
              ListTile(
                  leading:
                      Icon(Icons.smartphone, size: 22, color: Colors.black),
                  title: Text(
                    "Set on both screens",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  onTap: () => setWallpaper(3, context)),
              ListTile(
                  leading: Icon(Icons.download, size: 22, color: Colors.black),
                  title: Text(
                    "Save to gallery",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  onTap: () => downloadWall(context)),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 25, 30, 49),
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 38),
                ),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  setWallpaper(int num, BuildContext context) async {
    try {
      String url = wallpaper['url']; // Image URL

      // Download & cache the image
      File cachedImage = await DefaultCacheManager().getSingleFile(url);

      // Choose screen type
      int location;
      if (num == 1) {
        location = WallpaperManagerPlus.homeScreen;
      } else if (num == 2) {
        location = WallpaperManagerPlus.lockScreen;
      } else {
        location = WallpaperManagerPlus.bothScreens;
      }

      // Set wallpaper
      await WallpaperManagerPlus().setWallpaper(cachedImage, location);

      debugPrint("Wallpaper set successfully!");
      Navigator.pop(context);
      showSuccessPopup(context);
    } catch (e) {
      debugPrint("Error setting wallpaper: $e");
    }
  }

  void downloadWall(BuildContext context) async {
    try {
      final uri = Uri.parse(wallpaper['url']);
      final response = await http.get(uri);
      final bytes = response.bodyBytes;

      // Get current date and time without using intl
      DateTime now = DateTime.now();
      String timestamp =
          "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_"
          "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";

      // Save to gallery using image_gallery_saver
      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        name: "Vibe => $timestamp", // Name for the image
      );

      if (result['isSuccess'] == true) {
        debugPrint("Image saved successfully to gallery!");
        Navigator.pop(context);
        showdownloadedPopup(context);
      } else {
        debugPrint("Failed to save image to gallery.");
      }
    } catch (e) {
      debugPrint("Error downloading image: $e");
    }
  }

  void showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Wallpaper set!",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text(
              "All done! Your phone looks amazing.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "DISMISS",
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showdownloadedPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Wallpaper downloaded!",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text(
              "Keep on vibing with us",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "DISMISS",
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
