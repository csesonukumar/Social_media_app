
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/reuse.dart';
import 'OtpScreen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController PhoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Reuse.customTextField(
                controller: PhoneController,
                keyboardType: TextInputType.text,
                label: "Enter Phone Number",
                toHide: false,
                iconData: Icons.phone),
            Reuse.customElevatedButton(
                text: "Send Otp",
                onPressed: () async {
                  FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationid, int? resendtoken) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen(verificationid: verificationid,)));
                      },
                      codeAutoRetrievalTimeout: (String verificationid) {},
                      phoneNumber: PhoneController.text.toString());
                }),
          ],
        ),
      ),
    );
  }
}
