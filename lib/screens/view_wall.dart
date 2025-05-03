import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:visual_vibes/screens/full_wall.dart';
import 'package:visual_vibes/widgets/view-wall/icon_list.dart';

class ViewWall extends StatelessWidget {
  final Map<String, dynamic> wallpaper;

  const ViewWall({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 64, 142, 144),
              Color.fromARGB(255, 227, 104, 89),
            ])),
        child: Column(
          children: [
            AppBar(backgroundColor: Color.fromARGB(0, 0, 0, 0)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FullWall(imageUrl: wallpaper['url']),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: AspectRatio(
                          aspectRatio: 1.1 / 2, // Set aspect ratio
                          child: 
                          CachedNetworkImage(
                            imageUrl: wallpaper['url'],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.453,
                    child: IconList(wallpaper: wallpaper),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
