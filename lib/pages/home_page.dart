import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_midia_firebase/database/firestore.dart';
import 'package:social_midia_firebase/widgets/drawer_widget.dart';
import 'package:social_midia_firebase/widgets/list_tiles_widget.dart';
import 'package:social_midia_firebase/widgets/my_text_field.dart';
import 'package:social_midia_firebase/widgets/post_button_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase database = FirestoreDatabase();

  TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPosts(message);
    }

    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'W A L L',
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    hintText: "Say something",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                PostButtonWidget(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          // POSTS

          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              print("snapshot => ${snapshot.data}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final posts = snapshot.data!.docs;

              print("posts => $posts");

              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('No posts... Post something!'),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post["PostMessage"];
                    String useEmail = post["UserEmail"];
                    Timestamp timestamp = post["TimeStamp"];

                    return ListTileWidget(title: message, subTitle: useEmail);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
