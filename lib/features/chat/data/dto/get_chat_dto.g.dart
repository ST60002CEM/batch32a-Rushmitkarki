// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_chat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChatDto _$GetChatDtoFromJson(Map<String, dynamic> json) => GetChatDto(
      results: (json['results'] as List<dynamic>)
          .map((e) => ChatApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetChatDtoToJson(GetChatDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
