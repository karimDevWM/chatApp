import 'package:chat2/colors.dart';
import 'package:chat2/drawer.dart';
import 'package:chat2/models/conversations.dart';
import 'package:chat2/pages/list_page.dart';
import 'package:chat2/pages/messages_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat2/services/conversations_services.dart';
import 'package:chat2/styles.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';


class HomePage extends ListPage {
  static String name = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget? getDrawer(BuildContext context) {
    return getAppDrawer(context);
  }

  @override
  Widget getBody() {
    return FirestoreListView<Conversation>(
      query: ConversationsServices.getAll()
          .where(
            'between',
            arrayContains: FirebaseAuth.instance.currentUser!.email,
          )
          .orderBy(
            'lastMessageAt',
            descending: true,
          ),
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, snapshot) {
        final conversation = snapshot.data();
        return Column(
          children: [
            InkWell(
              splashColor: kGrey,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessagesPage(
                      conversation: conversation,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(conversation.name),
                trailing: const Icon(
                  Icons.arrow_right,
                  size: 40,
                ),
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}