// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageApiModel _$MessageApiModelFromJson(Map<String, dynamic> json) =>
    MessageApiModel(
      id: json['_id'] as String?,
      sender: json['sender'] == null
          ? null
          : AuthApiModel.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String?,
      chat: ChatApiModel.fromJson(json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageApiModelToJson(MessageApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sender': instance.sender,
      'content': instance.content,
      'chat': instance.chat,
    };
