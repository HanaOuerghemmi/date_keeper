import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/core/utils/help_padding.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  HomeAppBar({required this.userName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
       automaticallyImplyLeading: false, 
elevation: 1,
      title: Row(
        children: [
        const  CircleAvatar(
  backgroundImage: NetworkImage('https://img.freepik.com/vecteurs-libre/cercle-bleu-utilisateur-blanc_78370-4707.jpg?t=st=1729240089~exp=1729243689~hmac=f100922a642e7a3b23b8e6f23071503f5a135041e6d105e6fdb87ae02f65b3c2&w=740'),
            radius: 24,
          ),
smallPaddingHor,          // Greeting Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello,"),
              Text(userName),

            ],
          ),
        ],
      ),
      actions: [
        // Settings/ Menu Icon Button
        IconButton(
          icon: Icon(Icons.settings), // You can change this to Icons.menu if you prefer a menu icon
          onPressed: () {
            navigateGoOption(context: context, routeName: '/profile' );
            print("Settings/Menu pressed");
          },
        ),
      ],
    );
  }

  // Required to define the size of the AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
