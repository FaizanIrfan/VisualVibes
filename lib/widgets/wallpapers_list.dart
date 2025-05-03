import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visual_vibes/screens/view_wall.dart';

class WallpaperList extends StatefulWidget {
  final List<dynamic> wallpapers;
  const WallpaperList({super.key, required this.wallpapers});

  @override
  _WallpaperListState createState() => _WallpaperListState();
}

class _WallpaperListState extends State<WallpaperList> {
  static final Map<String, ImageProvider> _memoryCache = {}; // Store loaded images in memory

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.wallpapers.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), 
                shrinkWrap: true, 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  crossAxisSpacing: 10, 
                  mainAxisSpacing: 10, 
                  childAspectRatio: 1.15 / 2, 
                ),
                itemCount: widget.wallpapers.length,
                itemBuilder: (context, index) {
                  final wallpaper = widget.wallpapers[index];
                  final imageUrl = wallpaper['url'] ?? '';

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewWall(wallpaper: wallpaper),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _memoryCache.containsKey(imageUrl)
                          ? Image(
                              image: _memoryCache[imageUrl]!,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: const Color.fromARGB(255, 207, 207, 207),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image,
                                color: Colors.white,
                              ),
                              imageBuilder: (context, imageProvider) {
                                _memoryCache[imageUrl] = imageProvider; // Store image in memory cache
                                return Image(image: imageProvider, fit: BoxFit.cover);
                              },
                            ),
                    ),
                  );
                },
              ),
            )
          : const Center(child: Text('No wallpapers found')),
    );
  }
}
