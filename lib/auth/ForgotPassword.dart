import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/reuse.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller = TextEditingController();
  forgotpassword(String email)async{
    if(email ==""){
      return Reuse.customAlertBox(context: context, text: "Please enter email to Reset Password");
    }else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Reuse.customTextField(controller: emailcontroller, label: "email", toHide: false, iconData: Icons.mail),
          Reuse.customElevatedButton(text: "Forgot Password", onPressed: (){
            forgotpassword(emailcontroller.text.toString());
          })
        ],
      ),
    );
  }
}