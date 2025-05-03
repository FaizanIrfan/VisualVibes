import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_vibes/widgets/category_bars.dart';

class CategoryTab extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Abstract', 'image': 'assets/images/categories/abstract.png'},
    {'name': 'Art', 'image': 'assets/images/categories/art.png'},
    {'name': 'Beach', 'image': 'assets/images/categories/beach.png'},
    {'name': 'Bike', 'image': 'assets/images/categories/bike.png'},
    {'name': 'Car', 'image': 'assets/images/categories/car.png'},
    {'name': 'Gaming', 'image': 'assets/images/categories/gaming.png'},
    {'name': 'Music', 'image': 'assets/images/categories/music.png'},
    {'name': 'Nature', 'image': 'assets/images/categories/nature.png'},
    {'name': 'Rain', 'image': 'assets/images/categories/rain.png'},
    {'name': 'Space', 'image': 'assets/images/categories/space.png'},
    {'name': 'Travel', 'image': 'assets/images/categories/travel.png'},
    {'name': 'Wildlife', 'image': 'assets/images/categories/wildlife.png'},
  ];

  CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        elevation: 0,
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 12),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height * 0.4),
          ),
          itemBuilder: (context, index) {
            return CategoryBars(
              name: categories[index]['name']!,
              image: categories[index]['image']!,
              blur: 0.4,
              decision: true,
            );
          },
        ),
      ),
    );
  }
}
