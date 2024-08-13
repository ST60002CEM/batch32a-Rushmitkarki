// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatApiModel _$ChatApiModelFromJson(Map<String, dynamic> json) => ChatApiModel(
      id: json['_id'] as String,
      chatName: json['chatName'] as String,
      isGroupChat: json['isGroupChat'] as bool,
      users: (json['users'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupAdmin: json['groupAdmin'] == null
          ? null
          : AuthApiModel.fromJson(json['groupAdmin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatApiModelToJson(ChatApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'chatName': instance.chatName,
      'isGroupChat': instance.isGroupChat,
      'users': instance.users,
      'groupAdmin': instance.groupAdmin,
    };
