import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uicons/uicons.dart';
import 'package:visual_vibes/screens/search_screen.dart';
import 'package:visual_vibes/widgets/navigation_provider.dart';
import 'package:visual_vibes/widgets/category_bars.dart';
import 'package:visual_vibes/widgets/home-tab/image_slider.dart';

class UpperHalf extends StatelessWidget {
  const UpperHalf({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    return Container(
            padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
            child: Column(
              children: [
                Container(
                  // search bar
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 249, 249, 249),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.only(left: 25.0, right: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Find Wallpapers...',
                            hintStyle: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ),
                          autofocus: false,
                          canRequestFocus: false,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            UIcons.regularStraight.search,
                            size: 18,
                            color: const Color.fromARGB(255, 182, 182, 182),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                ImageSlider(),
                SizedBox(height: 16),
                Row(
                  // category and view all
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        navigationProvider
                            .setSelectedIndex(1); // Switch to Categories tab
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'View All',
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 64,142,144),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  // category bars
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryBars(
                        name: 'Nature',
                        image: 'assets/images/categories/nature.png',
                        blur: 0.5,
                        decision: false),
                    CategoryBars(
                        name: 'Gaming',
                        image: 'assets/images/categories/gaming.png',
                        blur: 0.2,
                        decision: false),
                    CategoryBars(
                        name: 'Music',
                        image: 'assets/images/categories/music.png',
                        blur: 0.3,
                        decision: false),
                    CategoryBars(
                        name: 'Rain',
                        image: 'assets/images/categories/rain.png',
                        blur: 0.25,
                        decision: false),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          );
  }
}