import 'package:json_annotation/json_annotation.dart';

import '../model/chat_api_model.dart';

part 'get_chat_dto.g.dart';

@JsonSerializable()
class GetChatDto {
  final List<ChatApiModel> results;

  GetChatDto({required this.results});

  factory GetChatDto.fromJson(Map<String, dynamic> json) =>
      _$GetChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetChatDtoToJson(this);
}
