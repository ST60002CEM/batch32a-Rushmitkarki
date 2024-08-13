import 'package:equatable/equatable.dart';

import '../../../auth/domain/entity/auth_entity.dart';
import 'message_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<AuthEntity> users;
  final MessageEntity? latestMessage;
  final AuthEntity? groupAdmin;

  ChatEntity(
      {required this.id,
      required this.chatName,
      required this.isGroupChat,
      required this.users,
      required this.latestMessage,
      required this.groupAdmin});

  @override
  List<Object?> get props =>
      [id, chatName, isGroupChat, users, latestMessage, groupAdmin];
}
