import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/LikeButton.dart';

class social_Post extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  const social_Post({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<social_Post> createState() => _social_PostState();
}

class _social_PostState extends State<social_Post> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // toggle like
  void toogleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Acess the document is Firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      // if the post is now liked, add the user's email to the 'Likes' field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      // if the post is now unliked, remove the user's email from the 'Likes' field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              // Like button
              LikeButton(
                isLiked: isLiked,
                onTap: toogleLike,
              ),

              const SizedBox(height: 5,),

              // Like count
              Text(widget.likes.length.toString(),style: TextStyle(color: Colors.grey,),),
            ],
          ),
          const SizedBox(
            width: 20,
          ),

          // message and user email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          )
        ],
      ),
    );
  }
}
