import '../../../auth/domain/entity/auth_entity.dart';
import '../../domain/entity/chat_entity.dart';

class ChatState {
  final List<ChatEntity> chats;
  final bool isLoading;
  final String? error;
  final AuthEntity? user;

  ChatState({
    required this.chats,
    required this.isLoading,
    required this.error,
    required this.user,
  });

  factory ChatState.initial() => ChatState(
        chats: [],
        isLoading: false,
        error: null,
        user: null,
      );

  ChatState copyWith({
    List<ChatEntity>? chats,
    bool? isLoading,
    String? error,
    AuthEntity? user,
  }) =>
      ChatState(
        chats: chats ?? this.chats,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}
