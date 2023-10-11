import 'package:chat2/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesServices {
  static CollectionReference<Messages> getAll(String conversationId) {
    final collectionRef = FirebaseFirestore.instance
      .collection('conversations')
      .doc(conversationId)
      .collection('messages');
    return collectionRef.withConverter<Messages>(
      fromFirestore: (snapshot, _) => Messages.fromJson(snapshot.data()!),
      toFirestore: (message, _) => message.toJson(),
    );
  }
}