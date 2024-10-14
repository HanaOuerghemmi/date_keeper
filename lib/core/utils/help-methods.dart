import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      text,
      // style: textStyleTextBold.copyWith(color: whiteColor),
      textAlign: TextAlign.center,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// String removeEmojis(String input) {
//   // Define a regex pattern to match emojis
//   final emojiRegex = RegExp(
//       r'[\u{1F600}-\u{1F64F}]|' // Emoticons
//       r'[\u{1F300}-\u{1F5FF}]|' // Miscellaneous Symbols and Pictographs
//       r'[\u{1F680}-\u{1F6FF}]|' // Transport and Map Symbols
//       r'[\u{2600}-\u{26FF}]|' // Miscellaneous Symbols
//       r'[\u{2700}-\u{27BF}]', // Dingbats
//       unicode: true);

//   // Replace all emojis with an empty string
//   return input.replaceAll(emojiRegex, '');
// }

// DateTime convertDateStringToDateTime(String dateString) {
//   print(dateString);
//   DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ');
//   try {
//     // Define the format according to the input date string (dd/MM/yyyy)

//     // Parse the date string to DateTime
//     DateTime dateTime = format.parse(dateString);
//     print("Converted DateTime: $dateTime");
//     return dateTime;
//   } catch (e) {
//     print("Error parsing date: $e");
//     return format.parse(DateTime.now().toString());
//   }
// }
