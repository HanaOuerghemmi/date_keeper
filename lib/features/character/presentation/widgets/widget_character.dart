import 'package:date_keeper/core/rooting/app_rooting.dart';
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
            navigateGoOption(context: context, routeName: '/createCaracter');
          //  Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => CreateCharacterPage()),
          //   ); 
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
