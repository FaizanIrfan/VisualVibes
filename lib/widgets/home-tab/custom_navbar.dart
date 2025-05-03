import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons/uicons.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomNavBar({super.key, required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(255, 249, 249, 249),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navbarOption('Trending', 0, UIcons.solidStraight.flame, context),
          navbarOption('Recent', 1, UIcons.solidStraight.clock, context),
          navbarOption('New', 2, UIcons.solidStraight.leaf, context),
        ],
      ),
    );
  }

  Widget navbarOption(String title, int index, IconData icon, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: selectedIndex == index
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 227,104,89),
                  Color.fromARGB(255, 64,142,144),
                ]
              )
            : null,
      ),
      child: TextButton(
        onPressed: () => onTabSelected(index), // Call function to change page
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedIndex == index ? Colors.white : Color.fromARGB(255, 64,142,144),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: selectedIndex == index ? Colors.white : Color.fromARGB(255, 64,142,144),
                fontSize: 11.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
