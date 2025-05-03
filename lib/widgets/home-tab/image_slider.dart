import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visual_vibes/screens/view_catgeory.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer; // Declare a timer variable

  final List<String> images = [
    'assets/images/slider/coal-black.png',
    'assets/images/slider/beach-life.png',
    'assets/images/slider/speed-snap.png'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          if (_currentPage < images.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer to prevent accessing disposed PageController
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Set the circular border radius
      child: Container(
        height: 180,
        width: double.infinity,
        color: Colors.grey,
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => ViewCategory(name: 'Vibes'))
                );
              },
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
