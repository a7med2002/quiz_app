import 'package:flutter/widgets.dart';

class Level {
  final String title;
  final String image;
  final IconData icon;
  final String description;
  final String subTitle;
  final List<Color> colors;

  Level({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.description,
    required this.colors,
    required this.image,
  });
}
