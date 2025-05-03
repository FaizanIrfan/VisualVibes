import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:uicons/uicons.dart';
import 'package:visual_vibes/screens/tabs/category_tab.dart';
import 'package:visual_vibes/screens/tabs/favorite_tab.dart';
import 'package:visual_vibes/screens/tabs/home_tab.dart';
import 'package:visual_vibes/screens/tabs/settings_tab.dart';
import 'package:visual_vibes/widgets/navigation_provider.dart';

class BottomNavBar extends StatelessWidget {

  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationProvider = Provider.of<NavigationProvider>(context);

    List<Widget> widgetList = [
      HomeTab(),
      CategoryTab(),
      FavoriteTab(),
      SettingsTab()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GNav(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        haptic: true,
        tabBorderRadius: 50,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600),
        gap: 7,
        color: const Color.fromARGB(255, 168, 168, 168),
        iconSize: 22,
        tabBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        tabMargin: const EdgeInsets.symmetric(vertical: 12),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: navigationProvider.selectedIndex,
        onTabChange: (index) {
          navigationProvider.setSelectedIndex(index);
        },
        tabs: [
          GButton(
            icon: UIcons.solidStraight.home,
            text: 'Home',
            iconSize: 19,
          ),
          GButton(
            icon: UIcons.solidStraight.list,
            text: 'Categories',
            iconSize: 19,
          ),
          GButton(
            icon: UIcons.solidStraight.heart,
            text: 'Favorites',
            iconSize: 19,
          ),
          GButton(
            icon: UIcons.solidStraight.settings,
            text: 'Settings',
            iconSize: 19,
          )
        ],
      ),
      body: widgetList[navigationProvider.selectedIndex],
    );
  }
}