import 'package:final_assignment/features/chat/domain/entity/message_entity.dart';

import '../../../auth/domain/entity/auth_entity.dart';

class MessageState {
  final List<MessageEntity> messages;
  final bool isLoading;
  final String? error;
  final AuthEntity? user;
  final List<AuthEntity> users;

  MessageState({
    required this.messages,
    required this.isLoading,
    required this.error,
    required this.user,
    required this.users,
  });

  factory MessageState.initial() => MessageState(
        messages: [],
        isLoading: false,
        error: null,
        user: null,
        users: [],
      );

  MessageState copyWith({
    List<MessageEntity>? messages,
    bool? isLoading,
    String? error,
    AuthEntity? user,
    List<AuthEntity>? users,
  }) =>
      MessageState(
        messages: messages ?? this.messages,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user,
        users: users ?? this.users,
      );
}
