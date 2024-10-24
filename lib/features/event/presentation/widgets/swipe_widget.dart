import 'package:flutter/material.dart';

  Widget swipeRightAction() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20)

      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.edit, color: Colors.white),
    );
  }

  Widget swipeLeftAction() {
    return Container(
      alignment: Alignment.centerRight,
       decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(20)

      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.delete, color: Colors.white),
    );
  }