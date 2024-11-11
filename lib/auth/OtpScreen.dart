import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:social_media_app/Pages/HomePage.dart';

import '../components/reuse.dart';
import 'login_or_register.dart';

class OtpScreen extends StatefulWidget {
  var verificationid;

  OtpScreen({super.key, required this.verificationid});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter the OTP sent to your mobile',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            Reuse.customTextField(
                controller: otpcontroller,
                label: "Enter otp here",
                toHide: false,
                iconData: Icons.phone,
                keyboardType: TextInputType.text),
            Reuse.customElevatedButton(
                text: "Verify",
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verificationid,
                            smsCode: otpcontroller.text.toString());
                    FirebaseAuth.instance.signInWithCredential(credential).then(
                        (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StreamBuilder(
                                  stream: FirebaseAuth.instance.authStateChanges(),
                                  builder: (context, snapshot) {
                                    // user is logged in
                                    if (snapshot.hasData) {
                                      return const HomePage();
                                      // user is not logged in
                                    } else {
                                      return const LoginOrRegister();
                                    }
                                  },
                                ))));
                  } catch (ex) {
                    log(ex.toString() as num);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
