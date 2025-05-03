import 'package:flutter/material.dart';
import 'package:visual_vibes/services/api_service.dart';
import 'package:visual_vibes/widgets/home-tab/upper_half.dart';
import 'package:visual_vibes/widgets/home-tab/navbar_delegate.dart';
import 'package:visual_vibes/widgets/wallpapers_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedIndex = 0; // Track selected navbar index

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch wallpapers based on selected tab
    final List<dynamic> wallpapers = [
      ApiService().getType('Trending'),
      ApiService().getType('Recent'),
      ApiService().getType('New'),
    ][_selectedIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: UpperHalf()),
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomNavBarDelegate(
                selectedIndex: _selectedIndex,
                onTabSelected: _onTabSelected, // Change wallpaper list
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: WallpaperList(wallpapers: wallpapers), // Update list dynamically
              ),
            ),
          ],
        ),
      ),
    );
  }
}
