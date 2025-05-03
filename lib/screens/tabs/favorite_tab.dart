import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_vibes/services/api_service.dart';
import 'package:visual_vibes/widgets/wallpapers_list.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> wallpaper = ApiService().getFavorites();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
          elevation: 0,
          title: Text(
            'Favorites',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: wallpaper.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Container(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: WallpaperList(wallpapers: wallpaper)))
                ],
              )
            : Center(
                child: Text('No favorite wallpapers :(',
                    style: GoogleFonts.poppins())));
  }
}
