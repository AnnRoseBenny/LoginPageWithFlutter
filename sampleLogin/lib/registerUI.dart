import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleLogin/homepage.dart';
import 'package:sampleLogin/loginUI.dart';
import 'package:sampleLogin/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isSaved = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final _registerformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isSaved
            ? Center(child: CircularProgressIndicator())
            : registerForm());
  }

  Widget registerForm() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, colors: [
        Colors.blue[100],
        Color(0xffefb7c1),
      ])),
      child: Form(
        key: _registerformkey,
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
                    "Register",
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
                    "Join Us",
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black38, blurRadius: 10),
                        Shadow(color: Colors.white, blurRadius: 10)
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
                                textFieldWithLabel(
                                    "Name", nameController, false),
                                textFieldWithLabel(
                                    "Email", emailController, false),
                                textFieldWithLabel(
                                    "Password", passwordController, true),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        customButton("Register", validateAndSignUp),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: clickableText("Already Have An Account? Login",
                              navigateToLogin, Colors.grey),
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

  navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NewLoginPage()),
        (route) => false);
  }

  validateAndSignUp() {
    if (_registerformkey.currentState.validate()) {
      _registerformkey.currentState.save();
      setState(() {
        isSaved = true;
      });
      registerUser();
    }
  }

  Future<void> registerUser() async {
    {
      if (_registerformkey.currentState.validate()) {
        _registerformkey.currentState.save();
        final _name = nameController.text.trim();
        final _email = emailController.text.trim();
        final _password = passwordController.text.trim();
        setState(() {
          isSaved = true;
        });
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .then((val) {
            firebaseFirestore.collection("users").doc(val.user.uid).set({
              'name': _name,
              'email': _email,
            });
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
        } on FirebaseAuthException catch (e) {
          setState(() {
            isSaved = false;
          });
          nameController.clear();
          passwordController.clear();
          emailController.clear();
          if (e.code == 'weak-password') {
            showDialogBox(context, "Weak Password", "Enter a new Password");
          } else if (e.code == 'email-already-in-use') {
            showDialogBox(context, "Email already in use", "Enter a new email");
          }
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }
}
