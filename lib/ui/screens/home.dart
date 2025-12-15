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
          Container(
            color: const Color(0xFF628A67),
          ),
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
}
