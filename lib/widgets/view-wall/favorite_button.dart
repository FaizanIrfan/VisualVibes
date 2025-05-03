import 'package:flutter/material.dart';
import 'package:visual_vibes/services/api_service.dart';
import 'package:uicons/uicons.dart';

class FavoriteButton extends StatefulWidget {
  final String wallpaperId;

  const FavoriteButton({super.key, required this.wallpaperId});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    bool result = ApiService().isFavorite(widget.wallpaperId);
    setState(() {
      isFavorite = result;
    });
  }

  Future<void> _toggleFavorite() async {
    await ApiService().addToFavorites(widget.wallpaperId, context);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(135, 25, 30, 49),
      ),
      child: IconButton(
        onPressed: _toggleFavorite,
        icon: Icon(
          isFavorite ? UIcons.solidStraight.heart : UIcons.regularStraight.heart,
          size: 18,
          color: isFavorite ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
