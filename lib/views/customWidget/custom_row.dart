import 'package:flutter/material.dart';

class CustomRow {
  Widget textWidget(String textOne, String secondText, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textOne,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          secondText,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
