import 'package:flutter/material.dart';

enum FloraType { fleur, feuille, fruit, plante }

class FloraSnap {
  final int? id;
  final String name;
  final String imagePath;
  final FloraType type;
  final DateTime date;
  final double latitude;
  final double longitude;
  final String description;

  FloraSnap({
    this.id,
    required this.name,
    required this.imagePath,
    required this.type,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'type': type.index,
      'date': date.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
  }

  factory FloraSnap.fromMap(Map<String, dynamic> map) {
    return FloraSnap(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      type: FloraType.values[map['type']],
      date: DateTime.parse(map['date']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      description: map['description'],
    );
  }
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
