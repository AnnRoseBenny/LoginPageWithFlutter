import 'package:flutter/material.dart';

Widget textFieldWithLabel(
    String label, TextEditingController textController, bool isHidden) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color.fromRGBO(37, 50, 255, .1),
        ),
      ),
    ),
    child: TextFormField(
      validator: (value) {
        if (value == null)
          return "This field is mandator";
        else
          return null;
      },
      controller: textController,
      obscureText: isHidden,
      decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none),
    ),
  );
}

Widget clickableText(String text, Function function, Color textcolor) {
  return Container(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: function,
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

Widget customButton(String label, Function function) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: function,
        splashColor: Color.fromARGB(200, 52, 43, 52),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color.fromARGB(200, 52, 43, 52),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void showDialogBox(
    BuildContext context, String titleString, String bodyString) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleString),
        content: Text(bodyString),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
