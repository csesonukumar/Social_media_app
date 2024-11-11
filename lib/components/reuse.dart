import 'package:flutter/material.dart';

class Reuse {
  static customAlertBox({
    required BuildContext context,
    required String text,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("ok"),
              ),
            ],
          );
        });
  }

  static customCircularProgressIndicator({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget customTextField({
    required TextEditingController controller,
    required String label,
    required bool toHide,
    required IconData iconData,
    TextInputType keyboardType = TextInputType.text, // Specify a default value
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
    );
  }

  static Widget customElevatedButton({
    required String text,
    required VoidCallback onPressed,
    hig = 50.0,
    wid = 150.0,
    fsize = 30.0,
    padsize = 10.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(padsize),
      child: SizedBox(
        height: hig,
        width: wid,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black, // Text color
            elevation: 5, // Button elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Button border radius
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fsize),
          ),
        ),
      ),
    );
  }

  static Widget customTextButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  // static customAlertBox({
  //   required BuildContext context,
  //   required String text,
  // }) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(text),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("OK"))
  //           ],
  //         );
  //       });
  // }
}
