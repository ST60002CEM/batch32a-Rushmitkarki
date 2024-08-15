// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_users_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUsersDto _$SearchUsersDtoFromJson(Map<String, dynamic> json) =>
    SearchUsersDto(
      success: json['success'] as bool,
      users: (json['users'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchUsersDtoToJson(SearchUsersDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'users': instance.users,
    };
