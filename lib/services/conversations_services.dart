import 'package:chat2/models/conversations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationsServices {
  static CollectionReference<Conversation> getAll() {
    final collectionReference = FirebaseFirestore.instance.collection('conversations');
    return collectionReference.withConverter<Conversation>(
      fromFirestore: (snapshot, _) => Conversation.fromJson(snapshot.id, snapshot.data()!), 
      toFirestore: (conversation, _) => conversation.toJson(),
    );
  }
}