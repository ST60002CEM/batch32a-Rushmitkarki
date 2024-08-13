import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/chat_entity.dart';
import 'message_api_model.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<AuthApiModel> users;

  final AuthApiModel? groupAdmin;

  const ChatApiModel(
      {required this.id,
      required this.chatName,
      required this.isGroupChat,
      required this.users,
      required this.groupAdmin});

  ChatApiModel.empty()
      : id = '',
        chatName = '',
        isGroupChat = false,
        users = [],
        groupAdmin = const AuthApiModel.empty();

  // from json
  factory ChatApiModel.fromJson(Map<String, dynamic> json) =>
      _$ChatApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatApiModelToJson(this);

  // to entity
  ChatEntity toEntity() {
    return ChatEntity(
        id: id,
        chatName: chatName,
        isGroupChat: isGroupChat,
        users: users.map((e) => e.toEntity()).toList(),
        groupAdmin: groupAdmin?.toEntity());
  }

  // from entity
  factory ChatApiModel.fromEntity(ChatEntity entity) {
    return ChatApiModel(
        id: entity.id,
        chatName: entity.chatName,
        isGroupChat: entity.isGroupChat,
        users: entity.users.map((e) => AuthApiModel.fromEntity(e)).toList(),
        groupAdmin: entity.groupAdmin != null
            ? AuthApiModel.fromEntity(entity.groupAdmin!)
            : null);
  }

  @override
  List<Object?> get props => [id, chatName, isGroupChat, users, groupAdmin];
}
