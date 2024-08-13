import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/chat/data/model/chat_api_model.dart';
import 'package:final_assignment/features/chat/domain/entity/message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_api_model.g.dart';

@JsonSerializable()
class MessageApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final AuthApiModel? sender;
  final String? content;
  final ChatApiModel chat;

  const MessageApiModel(
      {required this.id,
      required this.sender,
      required this.content,
      required this.chat});

  MessageApiModel.empty()
      : id = '',
        sender = const AuthApiModel.empty(),
        content = '',
        chat = ChatApiModel.empty();

  // from json
  factory MessageApiModel.fromJson(Map<String, dynamic> json) =>
      _$MessageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageApiModelToJson(this);

  // to entity
  MessageEntity toEntity() {
    return MessageEntity(
        id: id,
        sender: sender?.toEntity(),
        content: content,
        chat: chat.toEntity());
  }

  // from entity
  factory MessageApiModel.fromEntity(MessageEntity entity) {
    return MessageApiModel(
        id: entity.id,
        sender: entity.sender != null
            ? AuthApiModel.fromEntity(entity.sender!)
            : null,
        content: entity.content,
        chat: ChatApiModel.fromEntity(entity.chat));
  }

  @override
  List<Object?> get props => [id, sender, content, chat];
}
