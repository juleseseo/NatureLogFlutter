import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
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
}
