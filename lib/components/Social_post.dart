import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/CommentButton.dart';
import 'package:social_media_app/components/LikeButton.dart';
import 'package:social_media_app/helper/helperMethods.dart';
import 'comment.dart';

class social_Post extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;
  const social_Post({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<social_Post> createState() => _social_PostState();
}

class _social_PostState extends State<social_Post> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // comment text controller
  final commentTextController = TextEditingController();
  //
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

  // add a comment
  void addComment(String commentText) {
    // write the comment to firestore under the comments collection for this post
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Commemts")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now() // remember to format this when displaying
    });
  }

  // show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: commentTextController,
          decoration: InputDecoration(hintText: "Write a comment.."),
        ),
        actions: [
          // ----------Calcel Button
          TextButton(
            onPressed: () {
              // ----pop box
              Navigator.pop(context);
              // ------- clear controller
              commentTextController.clear();
            },
            child: Text("Cancel"),
          ),
          // -----------post button
          TextButton(
            onPressed: () {
              // -------add comment
              addComment(commentTextController.text);
              // --------pop box
              Navigator.pop(context);
              // ------- clear controller
              commentTextController.clear();
            },
            child: Text("Post"),
          ),
        ],
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------Social Post
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------message
              Text(widget.message),

              const SizedBox(height: 5),

              // --------user
              Row(
                children: [
                  Text(widget.user,style: TextStyle(color: Colors.grey[400])),
                  Text(" . ",style: TextStyle(color: Colors.grey[400])),
                  Text(widget.time,style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            ],
          ),

          const SizedBox(width: 20),

          // ------- buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ----------LIKE
              Column(
                children: [
                  // Like button
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toogleLike,
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  // Like count
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),
              // -------comment
              Column(
                children: [
                  // --------comment button
                  CommentButton(onTap: showCommentDialog),

                  const SizedBox(height: 5),

                  // ------ comment count
                  Text(
                    '0',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          //------- comments under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Commemts")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              // ------show loading circle if no data yet
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                shrinkWrap: true, // --------for nested lists
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // ----- get the comment
                  final commentData = doc.data() as Map<String, dynamic>;
                  // -----return the comment
                  return comment(
                    text: commentData["CommentText"],
                    user: commentData["CommentedBy"],
                    time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
