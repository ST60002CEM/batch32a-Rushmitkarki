import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/chat/domain/entity/chat_entity.dart';
import 'package:final_assignment/features/chat/domain/usecases/chat_usecase.dart';
import 'package:final_assignment/features/chat/presentation/navigator/chat_navigator.dart';
import 'package:final_assignment/features/chat/presentation/state/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/socket_service/socket_service.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(
    chatUsecase: ref.read(chatUsecaseProvider),
    authUseCase: ref.read(authUseCaseProvider),
    navigator: ref.read(chatNavigatorProvider),
  ),
);

class ChatViewModel extends StateNotifier<ChatState> {
  ChatViewModel(
      {required this.chatUsecase,
      required this.authUseCase,
      required this.navigator})
      : super(ChatState.initial());

  final ChatUsecase chatUsecase;
  final AuthUseCase authUseCase;
  final ChatViewNavigator navigator;
  final socket = SocketService.socket;

  init() {
    fetchChat();
    getAuthUser();
  }

  fetchChat() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await chatUsecase.getChats();
    result.fold((failure) {
      state = state.copyWith(error: failure.error, isLoading: false);
      showMySnackBar(message: failure.error.toString());
    }, (chats) {
      state = state.copyWith(chats: chats, isLoading: false, error: null);
    });
  }

  getAuthUser() async {
    final user = await authUseCase.getCurrentUser();
    user.fold((l) {
      state = state.copyWith(user: null);
    }, (r) {
      state = state.copyWith(user: r, error: null);
    });
  }

  searchUser(String query) async {
    state = state.copyWith(isLoading: true, error: null);
    final data = await authUseCase.searchUser(query);
    data.fold((l) {
      state = state.copyWith(error: l.error, isLoading: false);
      showMySnackBar(message: l.error.toString());
    }, (r) {
      state = state.copyWith(users: r, isLoading: false);
    });
  }

  createChat(AuthEntity? user) async {
    state = state.copyWith(isLoading: true, error: null);
    if (user == null) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: 'User not found');
      return;
    }

    final data = await chatUsecase.createChat(user!.userId ?? '');
    data.fold((l) {
      state = state.copyWith(error: l.error, isLoading: false);
      showMySnackBar(message: l.error.toString());
    }, (r) {
      state = state.copyWith(isLoading: false);
      fetchChat();
    });
  }

  createGroup(String name, List<AuthEntity> users) async {
    state = state.copyWith(isLoading: true, error: null);
    final data = await chatUsecase.createGroup(name, users);
    data.fold((l) {
      state = state.copyWith(error: l.error, isLoading: false);
      showMySnackBar(message: l.error.toString());
    }, (r) {
      state = state.copyWith(isLoading: false);
      fetchChat();
    });
  }

  // reset state
  resetState() {
    state = ChatState.initial();
    fetchChat();
    getAuthUser();
  }

  void joinChat(ChatEntity chat) {
    navigator.openChatView(chat);
  }

  @override
  void dispose() {
    print('ChatViewModel disposed');
    super.dispose();
  }
}
