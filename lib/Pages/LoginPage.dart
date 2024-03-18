// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:social_media_app/components/My_Text_Field.dart';
// import 'package:social_media_app/components/my_button.dart';
// import 'package:social_media_app/components/reuse.dart';

// class LoginPage extends StatefulWidget {
//   final Function()? onTap;
//   const LoginPage({
//     super.key,
//     required this.onTap,
//   });

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // text editing Controller
//   final emailTextController = TextEditingController();
//   final passwordTextController = TextEditingController();

//   // sign user in
//   signin() async {
//     // show loading circle
//     // Reuse.customCircularProgressIndicator(context: context);
//     showDialog(
//       context: context,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailTextController.text,
//         password: passwordTextController.text,
//       );

//       // pop loading circle
//       if (context.mounted) Navigator.pop(context);
//     } on FirebaseException catch (e) {
//       // display a dialog message
//       return Reuse.customAlertBox(
//         context: context,
//         text: e.code.toString(),
//       );
//     }
//   }

// // // display a dialog message
// //   void displayMessage(String message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text(message),
// //       ),
// //     );
// //   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey[300],
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 10),

//                 // logo
//                 Icon(
//                   Icons.lock,
//                   size: 100,
//                 ),

//                 // Welcome back message
//                 Text(
//                   "Welcome back, you've been missed!",
//                   style: TextStyle(
//                     color: Colors.grey[700],
//                   ),
//                 ),

//                 // email textfield
//                 MyTextField(
//                     controller: emailTextController,
//                     hintText: "Email",
//                     obsecureText: false),

//                 SizedBox(
//                   height: 10,
//                 ),

//                 // password textfield
//                 MyTextField(
//                     controller: passwordTextController,
//                     hintText: "Password",
//                     obsecureText: true),

//                 const SizedBox(height: 10),
//                 // sign in button
//                 MyButton(onTap: signin, text: "Sign In"),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Not a Member? ",
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: const Text(
//                         "Register now",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//                 // go to register page
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// circle avatar problem


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/My_Text_Field.dart';
import 'package:social_media_app/components/my_button.dart';
import 'package:social_media_app/components/reuse.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing Controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // sign user in
  Future<void> signin() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // display a dialog message
      Navigator.pop(context); // Dismiss the progress dialog if an error occurs
      return Reuse.customAlertBox(
        context: context,
        text: e.message ?? "An error occurred.",
      );
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

                const SizedBox(height: 10),
                // sign in button
                MyButton(onTap: signin, text: "Sign In"),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member? ",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
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

