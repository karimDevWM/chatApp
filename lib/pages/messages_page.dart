import 'package:chat2/colors.dart';
import 'package:chat2/models/conversations.dart';
import 'package:chat2/models/messages.dart';
import 'package:chat2/pages/list_page.dart';
import 'package:chat2/services/messages_services.dart';
import 'package:chat2/styles.dart';
import 'package:chat2/widgets/message_widget.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class MessagesPage extends ListPage {
  final Conversation conversation;

  const MessagesPage({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget getTitle() {
    return Text(
      conversation.name,
      style: appBarTitle,
    );
  }

  @override
  Widget getBody() {
    return Column(
      children: [
        Expanded(
          child: FirestoreListView<Messages>(
            reverse: true,
            query: MessagesServices.getAll(conversation.id).orderBy(
              'createdAt',
              descending: true,
            ),
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, snapshot) {
              final message = snapshot.data();
              return MessageWidget(message: message);
            },
          ),
        ),
        InputBottomAppBar(conversation: conversation),
      ],
    );
  }
}

class InputBottomAppBar extends StatefulWidget {
  final Conversation conversation;

  const InputBottomAppBar({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  State<InputBottomAppBar> createState() => _InputBottomAppBarState();
}

class _InputBottomAppBarState extends State<InputBottomAppBar> {
  final _textMessageController = TextEditingController();

  @override
  void dispose() {
    _textMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: Colors.white,
        child: Row(
          children: [
            //Bouton "+" pour ajouter du contenu au message
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: _textMessageController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  hintText: "Taper votre message...",
                  hintStyle: const TextStyle(color: kGrey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            //Bouton envoi du message
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              mini: true,
              onPressed: _sendMessage,
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Envoi le message
  void _sendMessage() {
    String textMessage = _textMessageController.text.trim();
    if (textMessage.isNotEmpty) {
      /* MessagesService.add(
        textMessage,
      ); */
    }
    _textMessageController.clear();
  }
}