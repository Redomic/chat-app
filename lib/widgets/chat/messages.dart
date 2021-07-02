import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) => Text(
              docs[index]['text']
          ),
          itemCount: docs.length,
        );
      },
    );
  }
}
