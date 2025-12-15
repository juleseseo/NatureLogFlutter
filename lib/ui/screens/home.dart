import 'package:flutter/material.dart';

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
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = <Widget>[
      const Center(child: Text('Eco Page')),
      const Center(child: Text('Search Page')),
      CameraScreen(camera: cameras.first),
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: const Color(0xFF628A67)),

                // Image de fond transparente
                Center(
                  child: Image.asset(
                    'resources/nature_log_logo.jpg',
                    width: 500,
                    height: 500,
                    fit: BoxFit.contain,
                    color: Colors.white.withOpacity(0.4),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),

                // Carousel un peu plus bas que le centre
                Align(
                  alignment: const Alignment(0, 0.3), // ajuste pour descendre le carousel
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
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
            ),
          ),

          // Footer

          Container(
            color: const Color(0xFF628A67),
          ),
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.eco, color: Colors.green,),
            label: 'Eco',
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

  // Fonction pour créer une carte
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
