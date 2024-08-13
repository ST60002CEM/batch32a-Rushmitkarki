import 'package:json_annotation/json_annotation.dart';

import '../model/message_api_model.dart';

part 'get_message_dto.g.dart';

@JsonSerializable()
class GetMessageDto {
  final List<MessageApiModel> messages;

  GetMessageDto({required this.messages});

  factory GetMessageDto.fromJson(Map<String, dynamic> json) =>
      _$GetMessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetMessageDtoToJson(this);
}
