import '../../../auth/domain/entity/auth_entity.dart';
import '../../domain/entity/chat_entity.dart';

class ChatState {
  final List<ChatEntity> chats;
  final bool isLoading;
  final String? error;
  final AuthEntity? user;
  final List<AuthEntity> users;

  ChatState({
    required this.chats,
    required this.isLoading,
    required this.error,
    required this.user,
    required this.users,
  });

  factory ChatState.initial() => ChatState(
        chats: [],
        isLoading: false,
        error: null,
        user: null,
        users: [],
      );

  ChatState copyWith({
    List<ChatEntity>? chats,
    bool? isLoading,
    String? error,
    AuthEntity? user,
    List<AuthEntity>? users,
  }) =>
      ChatState(
        chats: chats ?? this.chats,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user,
        users: users ?? this.users,
      );
}
