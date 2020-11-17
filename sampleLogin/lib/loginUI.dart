import 'package:flutter/material.dart';
import 'package:sampleLogin/widgets.dart';

class NewLoginPage extends StatefulWidget {
  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginForm(),
    );
  }

  Widget loginForm() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
        Colors.blue[100],
        Color(0xffefb7c1),
      ])),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(150, 52, 43, 52),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      shadows:[
                        Shadow(color: Colors.black38,blurRadius: 10),                       
                        Shadow(color: Colors.white,blurRadius: 10)
                      ],
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 3, right: 3),
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, right: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[50],
                                  blurRadius: 10,
                                  offset: Offset(2.5, 2.5),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                textFieldWithLabel("Email", false),
                                textFieldWithLabel("Password", true),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        clickableText("Forgot Password?", Colors.grey),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
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
                                    "Login",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: clickableText("New here?Join Us", Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
