import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class WidgetCharacterShimmer extends StatelessWidget {
  const WidgetCharacterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Adjust alignment as needed
          children: List.generate(
              3,
              (index) => Container(
                padding:const  EdgeInsets.all(16),
                    width: 100.0, // Circle diameter
                    height: 100.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )),
        ));
  }
}
