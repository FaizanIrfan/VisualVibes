import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visual_vibes/screens/bottom_navbar.dart';
import 'package:visual_vibes/services/api_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ApiService supabaseService = ApiService();

  Future<void> getData() async {
    try {
      await supabaseService.getDataFromSupabase();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ),
        );
      }
    });

    getData(); // Fetch data while waiting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/SplashImage.jpeg',
              height: 290,
            ),
            const SizedBox(height: 50),
            LoadingAnimationWidget.hexagonDots(
              color: const Color.fromARGB(255, 146, 151, 149),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
