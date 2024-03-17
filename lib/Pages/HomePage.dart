import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/My_Text_Field.dart';
import 'package:social_media_app/components/Social_post.dart';
import 'package:social_media_app/components/reuse.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // sign user out
  void signout() {
    FirebaseAuth.instance.signOut();
  }

  // post Message Method / Function
  post_Message() {
    // only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      // store in firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now()
      });
    }
  }

  // User
  final currentUser = FirebaseAuth.instance.currentUser!;

  // text controller
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: signout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // social App
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(" User Posts ")
                      .orderBy(
                        "Timestamp",
                        descending: false,
                      )
                      .snapshots(),
                  builder: (context, shapshot) {
                    if (shapshot.hasData) {
                      return ListView.builder(
                        itemCount: shapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // get the message
                          final post = shapshot.data!.docs[index];
                          return social_Post(
                            message: post['Message'],
                            user: post['UserEmail'],
                          );
                        },
                      );
                    } else if (shapshot.hasError) {
                      return Center(
                        child: Text('Error:${shapshot.error}'),
                      );
                    }
                    return Reuse.customCircularProgressIndicator(
                        context: context);
                  },
                ),
              ),
        
              // Post Message
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                          controller: textController,
                          hintText: " Write something on the Social App ",
                          obsecureText: false),
                    ),
        
                    // post button
                    IconButton(
                      onPressed: post_Message,
                      icon: const Icon(Icons.arrow_circle_up),
                    ),
                  ],
                ),
              ),
        
              // logged in as
              Text(" Logged in as: " + currentUser.email!),
            ],
          ),
        ),
      ),
    );
  }
}
