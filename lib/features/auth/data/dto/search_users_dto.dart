import 'package:json_annotation/json_annotation.dart';

import '../model/auth_api_model.dart';

part 'search_users_dto.g.dart';

@JsonSerializable()
class SearchUsersDto {
  final bool success;

  final List<AuthApiModel> users;

  SearchUsersDto({
    required this.success,
    required this.users,
  });

  factory SearchUsersDto.fromJson(Map<String, dynamic> json) =>
      _$SearchUsersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUsersDtoToJson(this);
}
