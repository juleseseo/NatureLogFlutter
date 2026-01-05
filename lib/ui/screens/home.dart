import 'package:flutter/material.dart';
import 'package:nature_log_flutter/ui/screens/herbarium.dart';
import 'package:nature_log_flutter/ui/screens/search_plants.dart';
import '../../main.dart';
import 'camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),               // 🏠 HOME
      const HerbariumPage(),             // 🌿 Herbarium
      const SearchPlantsScreen(),        // 🔍 Search
      CameraScreen(camera: cameras.first), // 📷 Camera
    ];

    return Scaffold(
      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF628A67),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Herbarium',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
        ],
      ),
    );
  }

  // ---------------- HOME CONTENT ----------------

  Widget _buildHomeContent() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: const Color(0xFF628A67)),

        Center(
          child: Image.asset(
            'resources/nature_log_logo.jpg',
            width: 300,
            fit: BoxFit.contain,
            color: Colors.white.withOpacity(0.4),
            colorBlendMode: BlendMode.modulate,
          ),
        ),

        Align(
          alignment: const Alignment(0, 0.3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Vos 5 derniers FloraSnaps !',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildCard('Plante 1', 'resources/plante1.jpeg'),
                    _buildCard('Plante 2', 'resources/plante2.jpeg'),
                    _buildCard('Plante 3', 'resources/plante3.jpeg'),
                    _buildCard('Plante 4', 'resources/plante4.jpeg'),
                    _buildCard('Plante 5', 'resources/plante5.jpeg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, String imagePath) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
