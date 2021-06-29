import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/IezH0IlU7z1aN7Bw2Foa/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(docs[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // FirebaseFirestore.instance
          //     .collection('chats/IezH0IlU7z1aN7Bw2Foa/messages')
          //     .snapshots()
          //     .listen((data) {
          //       data.docs.forEach((document) {
          //         print(document['text']);
          //       });
          // });
          FirebaseFirestore.instance
              .collection('chats/IezH0IlU7z1aN7Bw2Foa/messages')
              .add({
                'text': 'Added another entry'
              });
        },
      ),
    );
  }
}
