import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/chat/domain/usecases/chat_usecase.dart';
import 'package:final_assignment/features/chat/presentation/state/message_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/show_my_snackbar.dart';

final chatMessageViewModelProvider =
    StateNotifierProvider<ChatMessageViewModel, MessageState>(
  (ref) => ChatMessageViewModel(
    chatUsecase: ref.read(chatUsecaseProvider),
    authUseCase: ref.read(authUseCaseProvider),
  ),
);

class ChatMessageViewModel extends StateNotifier<MessageState> {
  ChatMessageViewModel({
    required this.chatUsecase,
    required this.authUseCase,
  }) : super(MessageState.initial());

  final ChatUsecase chatUsecase;
  final AuthUseCase authUseCase;

  void init(String id) {
    fetchMessages(id);
    getAuthUser();
  }

  fetchMessages(String id) {
    state = state.copyWith(isLoading: true);
    chatUsecase.getMessages(id).then((result) {
      result.fold((failure) {
        state = state.copyWith(error: failure.error, isLoading: false);
        showMySnackBar(message: failure.error.toString());
      }, (messages) {
        state = state.copyWith(messages: messages, isLoading: false);
      });
    });
  }

  getAuthUser() async {
    final user = await authUseCase.getCurrentUser();
    user.fold((l) {
      state = state.copyWith(user: null);
    }, (r) {
      state = state.copyWith(user: r);
    });
  }
}
