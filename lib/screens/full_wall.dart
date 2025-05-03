import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullWall extends StatelessWidget {
  final String imageUrl;

  const FullWall({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
          ),
        ),
      ),
    );
  }
}