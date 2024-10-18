import 'package:flutter/material.dart';

class CharacterScreen extends StatelessWidget {
  final String image;
  final String name;
  const CharacterScreen({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Image.network(image)
        ],
      ),
    );
  }
}