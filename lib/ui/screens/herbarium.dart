import 'package:flutter/material.dart';

enum FloraType { fleur, feuille, fruit, plante }

class FloraSnap {
  final String name;
  final String imagePath;
  final FloraType type;

  FloraSnap({
    required this.name,
    required this.imagePath,
    required this.type,
  });
}

class HerbariumPage extends StatefulWidget {
  const HerbariumPage({super.key});

  @override
  State<HerbariumPage> createState() => _HerbariumPageState();
}

class _HerbariumPageState extends State<HerbariumPage> {
  FloraType selectedType = FloraType.fleur;

  final List<FloraSnap> snaps = [
    FloraSnap(
      name: 'Rose sauvage',
      imagePath: 'resources/plante1.jpeg',
      type: FloraType.fleur,
    ),
    FloraSnap(
      name: 'Feuille de chêne',
      imagePath: 'resources/plante2.jpeg',
      type: FloraType.feuille,
    ),
    FloraSnap(
      name: 'Pomme verte',
      imagePath: 'resources/plante3.jpeg',
      type: FloraType.fruit,
    ),
    FloraSnap(
      name: 'Jeune érable',
      imagePath: 'resources/plante4.jpeg',
      type: FloraType.plante,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSnaps =
    snaps.where((snap) => snap.type == selectedType).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Herbier'),
        backgroundColor: const Color(0xFF628A67),
      ),
      body: Column(
        children: [
          // Dropdown filtre
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<FloraType>(
                  value: selectedType,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (FloraType? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedType = newValue;
                      });
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: FloraType.fleur,
                      child: Text('🌸 Fleurs'),
                    ),
                    DropdownMenuItem(
                      value: FloraType.feuille,
                      child: Text('🍃 Feuilles'),
                    ),
                    DropdownMenuItem(
                      value: FloraType.fruit,
                      child: Text('🍎 Fruits'),
                    ),
                    DropdownMenuItem(
                      value: FloraType.plante,
                      child: Text('🌱 Plante entière'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Grille Pokédex
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredSnaps.length,
              itemBuilder: (context, index) {
                final snap = filteredSnaps[index];
                return _buildFloraCard(snap);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloraCard(FloraSnap snap) {
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
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                snap.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  snap.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  _iconForType(snap.type),
                  color: Colors.green,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForType(FloraType type) {
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
}
