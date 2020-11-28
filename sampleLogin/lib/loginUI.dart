import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleLogin/homepage.dart';
import 'package:sampleLogin/registerUI.dart';
import 'package:sampleLogin/widgets.dart';
import 'package:sampleLogin/forgotscreen.dart';

class NewLoginPage extends StatefulWidget {
  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  bool isSaved = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final _loginformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            isSaved ? Center(child: CircularProgressIndicator()) : loginForm());
  }

  Widget loginForm() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, colors: [
        Colors.blue[100],
        Color(0xffefb7c1),
      ])),
      child: Form(
        key: _loginformkey,
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
                                    "Email", emailController, false),
                                textFieldWithLabel(
                                    "Password", passwordController, true),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        clickableText(
                            "Forgot Password?", forgotPass, Colors.grey),
                        SizedBox(
                          height: 20,
                        ),
                        customButton("Login", validateAndSignIn),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: clickableText("New here?Join Us",
                              navigateToSignUp, Colors.grey),
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

  forgotPass() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotScreen()));
  }

  navigateToSignUp() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignUpPage()),
        (route) => false);
  }

  validateAndSignIn() {
    if (_loginformkey.currentState.validate()) {
      _loginformkey.currentState.save();
      setState(() {
        isSaved = true;
      });
      signIn();
    }
  }

  Future<void> signIn() async {
    final _email = emailController.text.trim();
    final _password = passwordController.text.trim();
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password);
      if (userCredential.user.uid != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isSaved = false;
      });
      emailController.clear();
      passwordController.clear();
      if (e.code == 'invalid-email') {
        showDialogBox(
            context, "Invalid Email Address", "Enter another email address");
      }
      if (e.code == 'wrong-password') {
        showDialogBox(context, "Incorrect Password", "Check Your Password");
      }
      if (e.code == 'user-not-found') {
        showDialogBox(context, "User not Found", "Please login with us");
      }
    } catch (e) {
      print(e.message);
    }
  }
}
