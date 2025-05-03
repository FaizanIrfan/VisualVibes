import 'package:flutter/material.dart';
import 'package:visual_vibes/widgets/view-wall/favorite_button.dart';
import 'package:visual_vibes/widgets/view-wall/set_wall.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uicons/uicons.dart';
import 'dart:io';

class IconList extends StatelessWidget {
  final Map<String, dynamic> wallpaper;
  const IconList({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color.fromARGB(135, 25, 30, 49),
          ),
          child: IconButton(
              onPressed: () {
                shareWall();
              },
              icon: Icon(
                UIcons.regularStraight.share,
                size: 18,
                color: Colors.white,
              )),
        ),
        Container(
          height: 51,
          width: 51,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: SettingWall(wallpaper: wallpaper)
        ),
        FavoriteButton(wallpaperId: wallpaper['id']),
      ],
    );
  }

  

  void shareWall() async {
    try {
      final uri = Uri.parse(wallpaper['url']);
      final response = await http.get(uri);
      final bytes = response.bodyBytes;

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/wallpaper.jpg');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)],
          text: "Check out this cool wallpaper from Visual Vibes!");
      
    } catch (e) {
      debugPrint("Error sharing image: $e");
    }
  }
}