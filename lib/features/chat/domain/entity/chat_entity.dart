import 'package:equatable/equatable.dart';

import '../../../auth/domain/entity/auth_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<AuthEntity> users;
  final AuthEntity? groupAdmin;

  ChatEntity(
      {required this.id,
      required this.chatName,
      required this.isGroupChat,
      required this.users,
      required this.groupAdmin});

  @override
  List<Object?> get props => [id, chatName, isGroupChat, users, groupAdmin];
}
