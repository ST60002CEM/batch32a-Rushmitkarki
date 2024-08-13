// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMessageDto _$GetMessageDtoFromJson(Map<String, dynamic> json) =>
    GetMessageDto(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMessageDtoToJson(GetMessageDto instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
