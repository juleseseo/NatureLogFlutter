import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/flora_snap.dart';

class HerbariumRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'herbarium.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE plants(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, imagePath TEXT, type INTEGER, date TEXT, latitude REAL, longitude REAL, description TEXT)',
        );
      },
    );
  }

  Future<bool> plantExists(String name) async {
    final db = await database;
    final result = await db.query(
      'plants',
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.isNotEmpty;
  }

  Future<void> addPlant(FloraSnap plant) async {
    final db = await database;
    await db.insert('plants', plant.toMap());
  }

  Future<List<FloraSnap>> getAllPlants() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'plants',
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => FloraSnap.fromMap(maps[i]));
  }

  Future<String> saveImage(File imageFile, String plantName) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${directory.path}/plant_images');

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    final fileName = '${plantName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedPath = '${imagesDir.path}/$fileName';

    await imageFile.copy(savedPath);
    return savedPath;
  }

  Future<void> deletePlant(int id, String imagePath) async {
    final db = await database;
    await db.delete('plants', where: 'id = ?', whereArgs: [id]);

    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
