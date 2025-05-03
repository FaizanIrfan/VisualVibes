import 'package:flutter/material.dart';
import 'package:visual_vibes/widgets/home-tab/custom_navbar.dart';

class CustomNavBarDelegate extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final Function(int) onTabSelected;

  CustomNavBarDelegate({required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.only(left: 25, bottom: 6, right: 25),
      color: const Color.fromARGB(255, 227, 227, 227),
      child: CustomNavBar(
        selectedIndex: selectedIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
