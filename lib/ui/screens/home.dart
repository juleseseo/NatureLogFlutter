import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Zone centrale avec image + carousel
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Fond vert
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
            height: 120,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.eco,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
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
