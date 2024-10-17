import 'package:date_keeper/features/character/presentation/pages/create_character_page.dart';
import 'package:flutter/material.dart';

class WidgetCharacter extends StatelessWidget {
  const WidgetCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Character'),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateCharacterPage()),
            );
          },
          child: CircleAvatar(
            child: Icon(Icons.add),
            radius: 30,
          ),
        ),
      ],
    );
  }
}
