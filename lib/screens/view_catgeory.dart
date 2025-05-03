import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_vibes/services/api_service.dart';
import 'package:visual_vibes/widgets/custom_appbar.dart';
import 'package:visual_vibes/widgets/wallpapers_list.dart';

class ViewCategory extends StatelessWidget {
  final String name;
  const ViewCategory({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    List<dynamic> wallpapers = [];
    if (name == 'Vibes') {
      wallpapers = ApiService().fetchAllWallpapers();
    } else {
      wallpapers = ApiService().getCategory(name);
    }
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        appBar: CustomAppBar(title: name),
        body: wallpapers.isNotEmpty
            ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: WallpaperList(wallpapers: wallpapers)))
              ],
            )
            : Center(
                child: Text('No wallpapers in this category',
                    style: GoogleFonts.poppins())));
  }
}
