import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/core/utils/help_padding.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? profileImageUrl; 
  HomeAppBar({required this.userName, this.profileImageUrl});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      title: Row(
        children: [
          // If profileImageUrl is null or empty, show default Icon
          profileImageUrl != null && profileImageUrl!.isNotEmpty
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(profileImageUrl!),
                  onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 48),
                )
              : const CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.person, size: 40, color: primaryColor,),
                ),
          smallPaddingHor,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_getGreeting(), style: Theme.of(context).textTheme.bodyLarge),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    userName,
                    key: ValueKey(userName), 
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            navigateGoOption(context: context, routeName: '/profile');
            print("Settings/Menu pressed");
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
