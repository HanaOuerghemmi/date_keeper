import 'package:flutter/material.dart';

  Future<bool> showConfirmationDialog(
      BuildContext context, String title, String content) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // User cancels
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // User confirms
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
