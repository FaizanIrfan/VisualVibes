import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visual_vibes/screens/splash_screen.dart';
import 'package:visual_vibes/widgets/navigation_provider.dart';

import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://baztdqtetblskywqycxa.supabase.co', // Supabase Project URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJhenRkcXRldGJsc2t5d3F5Y3hhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI3MjA5ODQsImV4cCI6MjA0ODI5Njk4NH0.bpx6_p56McdEPcVa6CkFfJ0aAptJbpncnuaZQ7FwAGY', // Supabase Public API Key
  );

  // Initialize Hive
  await Hive.initFlutter();

  // Open the necessary Hive boxes
  await ApiService().initHive();  // Ensure ApiService initializes Hive boxes

  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MyApp(),
    ),
  );
  disableScreenshot();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

final _noScreenshot = NoScreenshot.instance;
void disableScreenshot() async {
  bool result = await _noScreenshot.screenshotOff();
  debugPrint('Screenshot Off: $result');
}
