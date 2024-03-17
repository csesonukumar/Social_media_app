import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/My_Text_Field.dart';
import 'package:social_media_app/components/my_button.dart';
import 'package:social_media_app/components/reuse.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing Controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  sign_up() async {
    // show loading circle
    Reuse.customCircularProgressIndicator(context: context);

    // make sure password match
    if (passwordTextController.text != confirmPasswordTextController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      Reuse.customAlertBox(context: context, text: "Passwords don't match! ");
      return;
    }

    // try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Reuse.customCircularProgressIndicator(context: context);
      //show error to user
      Reuse.customAlertBox(context: context, text: e.code.toString(),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),

                Text("Register Page"),

                // logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),

                // Welcome back message
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                // email textfield
                MyTextField(
                    controller: emailTextController,
                    hintText: "Email",
                    obsecureText: false),

                SizedBox(
                  height: 10,
                ),

                // password textfield
                MyTextField(
                    controller: passwordTextController,
                    hintText: "Password",
                    obsecureText: true),

                SizedBox(
                  height: 10,
                ),

                // Confirm password textfield
                MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: "Confirm Password",
                    obsecureText: true),

                const SizedBox(height: 10),
                // sign up button
                MyButton(onTap: sign_up, text: "Sign up"),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
                // go to register page
              ],
            ),
          ),
        ),
      ),
    );
  }
}
