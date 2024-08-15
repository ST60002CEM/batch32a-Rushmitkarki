import 'package:final_assignment/core/socket_service/socket_service.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/chat/data/model/message_api_model.dart';
import 'package:final_assignment/features/chat/domain/usecases/chat_usecase.dart';
import 'package:final_assignment/features/chat/presentation/state/message_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/show_my_snackbar.dart';
import '../navigator/chat_message_navigator.dart';

final chatMessageViewModelProvider =
    StateNotifierProvider<ChatMessageViewModel, MessageState>(
  (ref) => ChatMessageViewModel(
    chatUsecase: ref.read(chatUsecaseProvider),
    authUseCase: ref.read(authUseCaseProvider),
    navigator: ref.read(chatMessageNavigatorProvider),
  ),
);

class ChatMessageViewModel extends StateNotifier<MessageState> {
  ChatMessageViewModel({
    required this.chatUsecase,
    required this.authUseCase,
    required this.navigator,
  }) : super(MessageState.initial());

  final ChatUsecase chatUsecase;
  final AuthUseCase authUseCase;
  final ChatMessageViewNavigator navigator;

  final socket = SocketService.socket;

  void init(String id) {
    fetchMessages(id);
    getAuthUser();
    join();

    socket.on("disconnect", (_) {
      showMySnackBar(message: "Disconnected");
      join();
    });

    socket.on("receiveMessage", (data) {
      print(data);
      fetchMessages(id);
    });
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

  sendMessage(String content, String chatId) async {
    state = state.copyWith(isLoading: true);
    final data = await chatUsecase.sendMessage(content, chatId);
    data.fold((l) {
      state = state.copyWith(error: l.error, isLoading: false);
      showMySnackBar(message: l.error.toString());
    }, (r) {
      state = state.copyWith(isLoading: false);
      socket.emit("sendMessage", MessageApiModel.fromEntity(r).toJson());
      fetchMessages(chatId);
    });
  }

  leaveGroup(String id) async {
    state = state.copyWith(isLoading: true);
    final data = await chatUsecase.leaveGroup(id);
    data.fold((l) {
      state = state.copyWith(error: l.error, isLoading: false);
      showMySnackBar(message: l.error.toString());
    }, (r) {
      state = state.copyWith(isLoading: false);
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

  addUser(String chatId, AuthEntity? user) async {
    state = state.copyWith(isLoading: true);
    if (user == null) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: 'User not found');
      return;
    }
    final data = await chatUsecase.addUser(chatId, user?.userId ?? '');
    data.fold((l) {
      state = state.copyWith(error: l.error, isLoading: false);
      showMySnackBar(message: l.error.toString());
    }, (r) {
      state = state.copyWith(isLoading: false);
    });
  }

  join() {
    socket.emit("newUser", state.user?.userId ?? "Guest");

    //   dispose
    return () {
      socket.off("newUser");
    };
  }

  closeView() {
    navigator.pop();
  }
}
