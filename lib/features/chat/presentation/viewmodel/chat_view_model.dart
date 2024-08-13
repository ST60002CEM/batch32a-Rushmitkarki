import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/chat/domain/usecases/chat_usecase.dart';
import 'package:final_assignment/features/chat/presentation/state/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(
    chatUsecase: ref.read(chatUsecaseProvider),
    authUseCase: ref.read(authUseCaseProvider),
  ),
);

class ChatViewModel extends StateNotifier<ChatState> {
  ChatViewModel({required this.chatUsecase, required this.authUseCase})
      : super(ChatState.initial());

  final ChatUsecase chatUsecase;
  final AuthUseCase authUseCase;

  fetchChat() {
    state = state.copyWith(isLoading: true);
    chatUsecase.getChats().then((result) {
      result.fold((failure) {
        state = state.copyWith(error: failure.error, isLoading: false);
        showMySnackBar(message: failure.error.toString());
      }, (chats) {
        state = state.copyWith(chats: chats, isLoading: false);
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
