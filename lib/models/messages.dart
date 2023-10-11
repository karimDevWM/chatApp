import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  Messages({
    required this.message,
    required this.from,
    required this.createdAt,
  });
  Messages.fromJson(Map<String, Object?> json)
    : this(
        message: json['message'].toString(),
        from: json['from'].toString(),
        createdAt: json['createdAt'] as Timestamp,
      );

  final String message;
  final String from;
  final Timestamp createdAt;

  Map<String, Object?> toJson() {
    return {
      'message': message,
      'from': from,
      'createdAt': createdAt,
    };
  }
}