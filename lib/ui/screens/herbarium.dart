import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/flora_snap.dart';
import '../../repository/herbarium_repository.dart';
import '../../services/location_service.dart';
import '../widgets/flora_flip_card.dart';

class HerbariumPage extends StatefulWidget {
  const HerbariumPage({super.key});

  @override
  State<HerbariumPage> createState() => _HerbariumPageState();
}

class _HerbariumPageState extends State<HerbariumPage> {
  FloraType selectedType = FloraType.all;
  List<FloraSnap> snaps = [];
  bool isLoading = true;
  late HerbariumRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = HerbariumRepository();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    setState(() => isLoading = true);
    final plants = await _repository.getAllPlants();
    setState(() {
      snaps = plants;
      isLoading = false;
    });
  }

  Future<FloraSnap> createFloraSnap() async {
    final position = await LocationService.getCurrentPosition();

    return FloraSnap(
      name: 'FloraSnap test',
      imagePath: 'resources/plante1.jpeg',
      type: selectedType,
      date: DateTime.now(),
      latitude: position.latitude,
      longitude: position.longitude,
      description: 'Snap créé avec GPS réel',
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredSnaps = selectedType == FloraType.all
        ? snaps
        : snaps.where((s) => s.type == selectedType).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Herbier'),
          backgroundColor: const Color(0xFF628A67),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadPlants,
            ),
          ],
        ),
      body: Column(
        children: [
          _buildDropdown(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredSnaps.isEmpty
                ? const Center(child: Text('Aucune plante trouvée'))
                : _buildGrid(filteredSnaps),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DropdownButtonFormField<FloraType>(
        value: selectedType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: const [
          DropdownMenuItem(value: FloraType.all, child: Text('🌍 Tout')),
          DropdownMenuItem(value: FloraType.fleur, child: Text('🌸 Fleurs')),
          DropdownMenuItem(value: FloraType.feuille, child: Text('🍃 Feuilles')),
          DropdownMenuItem(value: FloraType.fruit, child: Text('🍎 Fruits')),
          DropdownMenuItem(value: FloraType.plante, child: Text('🌱 Plantes')),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedType = value);
          }
        },
      ),
    );
  }


  Widget _buildGrid(List<FloraSnap> snaps) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: snaps.length,
      itemBuilder: (context, index) {
        final snap = snaps[index];
        return FloraFlipCard(
          front: _frontCard(snap),
          back: _backCard(snap),
        );
      },
    );
  }



  Widget _frontCard(FloraSnap snap) {
    return _cardContainer(
        Column(
            children: [
        Expanded(
        child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    child: _buildImage(snap.imagePath),
    ),
    ),
    Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
    children: [
    Text(snap.name, style: const TextStyle(fontWeight: FontWeight.bold)),
    Icon(iconForType(snap.type), color: Colors.green),
    ],
    ),
    ),
            ],
        ),
    );
  }

  Widget _backCard(FloraSnap snap) {
    return _cardContainer(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info(Icons.calendar_today, formatDate(snap.date)),
            _info(Icons.location_on,
                '${snap.latitude.toStringAsFixed(4)}, ${snap.longitude.toStringAsFixed(4)}'),
            const SizedBox(height: 8),
            Text(snap.description),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.green),
        const SizedBox(width: 6),
        Expanded(child: Text(text)),
      ],
    );
  }

  // Container de carte
  Widget _cardContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('resources/')) {
      return Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity);
    } else {
      return Image.file(File(imagePath), fit: BoxFit.cover, width: double.infinity);
    }
  }
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
