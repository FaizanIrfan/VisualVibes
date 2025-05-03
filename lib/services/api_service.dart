import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal(); // Private constructor

  final SupabaseClient supabase = Supabase.instance.client;
  final user = Supabase.instance.client.auth.currentUser;

  late Box fetchedWallpapersBox;
  late Box favoriteWallpapersBox;

  bool isDataFetched = false;

  Future<void> initHive() async {
    fetchedWallpapersBox = await Hive.openBox('fetchedWallpapers');
    favoriteWallpapersBox = await Hive.openBox('favoriteWallpapers');
  }

  Future<List<Map<String, dynamic>>> getDataFromSupabase() async {
    try {
      if (!isDataFetched) {
        print('Fetching data...');
        final response = await supabase.from('Wallpapers').select().order(
            'uploaded_at',
            ascending: false); // Ensures recent entries appear first

        fetchedWallpapersBox.put('wallpapers', response);
        fetchedWallpapersBox.put('isFetched', true);
        print('Data fetched: ${response.length} items');
        isDataFetched = true;
      }

      return List<Map<String, dynamic>>.from(
        fetchedWallpapersBox.get('wallpapers', defaultValue: []),
      );
    } catch (e) {
      print("Error fetching data from Supabase: $e");
      return [];
    }
  }

  Future<void> addToFavorites(String id, BuildContext context) async {
    try {
      List<Map<String, dynamic>> favoriteWallpapers =
          List<Map<String, dynamic>>.from(
              (favoriteWallpapersBox.get('favorites', defaultValue: []) as List)
                  .map((e) => Map<String, dynamic>.from(e)));

      List<Map<String, dynamic>> fetchedWallpapers =
          await getDataFromSupabase();

      var wallpaper = fetchedWallpapers.firstWhere(
        (i) => i['id'] == id,
        orElse: () => <String, dynamic>{}, // Return empty map if not found
      );

      if (wallpaper.isEmpty) {
        print('Wallpaper with ID $id not found');
        return;
      }

      bool alreadyExists = favoriteWallpapers.any((j) => j['id'] == id);

      if (alreadyExists) {
        await removeFromFavorites(id, context);
      } else {
        favoriteWallpapers.add(wallpaper);
        print('Added to favorites with ID: $id');

        favoriteWallpapersBox.put('favorites', favoriteWallpapers);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Wallpaper added to favorites",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            backgroundColor: Color.fromARGB(255, 64, 142, 144),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error adding wallpaper to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String id, BuildContext context) async {
    List<Map<String, dynamic>> favoriteWallpapers =
        List<Map<String, dynamic>>.from(
            favoriteWallpapersBox.get('favorites', defaultValue: []));
    favoriteWallpapers.removeWhere((i) => i['id'] == id);
    favoriteWallpapersBox.put('favorites', favoriteWallpapers);

    print('Removed wallpaper with ID: $id');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Wallpaper removed from favorites",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          backgroundColor: const Color.fromARGB(255, 64, 142, 144),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  List<Map<String, dynamic>> getFavorites() {
    List<dynamic> favorites =
        favoriteWallpapersBox.get('favorites', defaultValue: []);

    return favorites.map((e) {
      if (e is Map<dynamic, dynamic>) {
        return Map<String, dynamic>.from(e);
      } else {
        return <String, dynamic>{};
      }
    }).toList();
  }

  List<Map<String, dynamic>> fetchAllWallpapers() {
    List<dynamic> wallpapers =
        fetchedWallpapersBox.get('wallpapers', defaultValue: []);

    return wallpapers.map((e) {
      if (e is Map<dynamic, dynamic>) {
        return Map<String, dynamic>.from(e);
      } else {
        return <String, dynamic>{};
      }
    }).toList();
  }

  bool isFavorite(String id) {
    List<dynamic> favorites =
        favoriteWallpapersBox.get('favorites', defaultValue: []);

    return favorites.any((e) {
      if (e is Map<dynamic, dynamic>) {
        return Map<String, dynamic>.from(e)['id'] == id;
      }
      return false;
    });
  }

  List<Map<String, dynamic>> getCategory(String name) {
    List<Map<String, dynamic>> fetchedWallpapers =
        List<Map<String, dynamic>>.from(
            fetchedWallpapersBox.get('wallpapers', defaultValue: []));

    if (fetchedWallpapers.isEmpty) {
      print('No wallpapers fetched yet.');
      return [];
    }

    return fetchedWallpapers.where((i) => i['category'] == name).toList();
  }

  List<Map<String, dynamic>> getType(String name) {
    List<dynamic> fetchedWallpapers =
        fetchedWallpapersBox.get('wallpapers', defaultValue: []);

    if (fetchedWallpapers.isEmpty) {
      print('No wallpapers fetched yet.');
      return [];
    }

    return fetchedWallpapers
        .where((i) => i is Map && i['type'] == name)
        .map((i) => Map<String, dynamic>.from(i))
        .toList();
  }

  Future<Map<String, dynamic>> getWallpaperById(String id) async {
    List<Map<String, dynamic>> allWallpapers = await getDataFromSupabase();
    return allWallpapers.firstWhere(
      (wallpaper) => wallpaper['id'] == id,
      orElse: () => <String, dynamic>{},
    );
  }
}
