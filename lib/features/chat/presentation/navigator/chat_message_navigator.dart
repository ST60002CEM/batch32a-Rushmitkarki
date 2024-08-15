import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/chat/domain/entity/chat_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/chat_message_view.dart';
import 'chat_navigator.dart';

final chatMessageNavigatorProvider =
    Provider((ref) => ChatMessageViewNavigator());

class ChatMessageViewNavigator with ChatViewRoute {
  void pop() {
    NavigateRoute.pop();
  }
}

mixin ChatMessageViewRoute {
  openChatView(ChatEntity chat) {
    NavigateRoute.pushRoute(ChatMessageView(
      chat: chat,
    ));
  }
}
