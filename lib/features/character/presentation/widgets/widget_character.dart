import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:flutter/material.dart';

class WidgetCharacter extends StatelessWidget {
  const WidgetCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CharcterItemWidget(
                  onTap: () => navigateGoOption(
                      context: context, routeName: '/createCaracter'),
                  image: Icon(Icons.add, size: 30),
                  text: 'New',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: characterList.map((character) {
                        return CharcterItemWidget(
                          onTap: () => navigateGoOption(
                            context: context,
                            routeName: '/charcter',
                            params: {
                              'name': character['name'],
                              'image': character['image'],
                            },
                          ),
                          image: Image.network(
                            character['image'],
                            fit: BoxFit.cover,
                          ),
                          text: character['name'],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CharcterItemWidget extends StatelessWidget {
  final Function() onTap;
  final Widget image;
  final String text;

  const CharcterItemWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0), // Increased horizontal padding
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: image,
                ),
              ),
            ),
            smallPaddingVert,
            Text(
              text,
              style: textStyleSubtitle.copyWith(fontSize: 9),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> characterList = [
  {
    'name': 'Character 1',
    'image':
        'https://img.freepik.com/photos-premium/homme-portant-lunettes-chemise-blanche-pouce-air_273179-14958.jpg?w=740',
  },
  {
    'name': 'Character 2',
    'image':
        'https://img.freepik.com/photos-gratuite/portrait-jeune-femme-affaires-tenant-lunettes-main-fond-gris_23-2148029483.jpg?t=st=1729245116~exp=1729248716~hmac=9a04f29257e64fc59d2a807f4bcbf4c3d09517f3587ed2d3ec8aba870b99d7e6&w=740',
  },
  {
    'name': 'Character 3',
    'image':
        'https://img.freepik.com/photos-premium/homme-portant-lunettes-chemise-blanche-pouce-air_273179-14958.jpg?w=740',
  },
  {
    'name': 'Character 4',
    'image':
        'https://img.freepik.com/photos-premium/homme-portant-lunettes-chemise-blanche-pouce-air_273179-14958.jpg?w=740',
  },
  {
    'name': 'Character 5',
    'image':
        'https://img.freepik.com/photos-premium/homme-portant-lunettes-chemise-blanche-pouce-air_273179-14958.jpg?w=740',
  },
];
