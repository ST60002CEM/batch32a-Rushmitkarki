import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/chat/presentation/navigator/chat_message_navigator.dart';
import 'package:final_assignment/features/chat/presentation/view/chat_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatNavigatorProvider = Provider((ref) => ChatViewNavigator());

class ChatViewNavigator with ChatMessageViewRoute {
  void pop() {
    NavigateRoute.pop();
  }
}

mixin ChatViewRoute {
  openChatView() {
    NavigateRoute.pushRoute(ChatView());
  }
}
