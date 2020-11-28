import 'package:flutter/material.dart';
import 'package:sampleLogin/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _resetformkey = GlobalKey<FormState>();
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _resetformkey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Password reset mail will be sent to your email",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWithLabel(
                    "Enter your email here...", editingController, false),
              ),
              SizedBox(
                height: 20,
              ),
              customButton("Reset", validateAndSendResetLink)
            ],
          ),
        ),
      ),
    );
  }

  void validateAndSendResetLink() {
    if (_resetformkey.currentState.validate()) {
      _resetformkey.currentState.save();
      String email = editingController.text.trim();
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      editingController.clear();
    }
  }
}
