import 'package:flutter/material.dart';

enum FloraType { fleur, feuille, fruit, plante }

class FloraSnap {
  final String name;
  final String imagePath;
  final FloraType type;
  final DateTime date;
  final double latitude;
  final double longitude;
  final String description;

  FloraSnap({
    required this.name,
    required this.imagePath,
    required this.type,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.description,
  });
}

IconData iconForType(FloraType type) {
  switch (type) {
    case FloraType.fleur:
      return Icons.local_florist;
    case FloraType.feuille:
      return Icons.eco;
    case FloraType.fruit:
      return Icons.apple;
    case FloraType.plante:
      return Icons.park;
  }
}
