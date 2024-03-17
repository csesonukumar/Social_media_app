import 'package:flutter/material.dart';

class social_Post extends StatelessWidget {
  final String message;
  final String user;
  const social_Post({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(user),
            Text(message),
          ],
        )
      ],
    );
  }
}
