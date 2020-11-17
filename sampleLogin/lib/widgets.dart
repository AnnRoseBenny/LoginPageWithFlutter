import 'package:flutter/material.dart';

Widget textFieldWithLabel(
    String label, bool isHidden) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color.fromRGBO(37, 50, 255, .1),
        ),
      ),
    ),
    child: TextFormField(
      obscureText: isHidden,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget clickableText(String text, Color textcolor) {
  return Container(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: Text(
          text,
          style: TextStyle(color: textcolor),
        ),
      ),
    ),
  );
}