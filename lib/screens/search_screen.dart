import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visual_vibes/widgets/wallpapers_list.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = []; // Holds the results from Supabase
  bool _isLoading = false; // Indicates loading state

  /// Method to fetch wallpapers based on a search query.
  Future<void> _searchWallpapers(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final supabase = Supabase.instance.client;

      // Break query into keywords
      final keywords = query.trim().split(RegExp(r'\s+'));

      // Construct ilike filters for each keyword
      final orFilter =
          keywords.map((keyword) => "description.ilike.%$keyword%").join(',');

      // Perform the query
      final response =
          await supabase.from('Wallpapers').select('*').or(orFilter);

      setState(() {
        _searchResults = response; // Set results
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 249, 249, 249),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Find Wallpapers...',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 182, 182, 182),
                      ),
                    ),
                    autofocus: true,
                    onSubmitted: _searchWallpapers,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: SearchResults(
              searchResults: _searchResults,
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    ));
  }
}

class SearchResults extends StatelessWidget {
  final List<dynamic> searchResults;
  final bool isLoading;

  const SearchResults({
    super.key,
    required this.searchResults,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (searchResults.isEmpty) {
      return const Center(
        child: Text(
          'No results found.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: WallpaperList(wallpapers: searchResults),
          ),
        ),
      ],
    );
  }
}
