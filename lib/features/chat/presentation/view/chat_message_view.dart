import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoint.dart';
import '../../../auth/domain/entity/auth_entity.dart';
import '../../domain/entity/chat_entity.dart';
import '../viewmodel/chat_message_view_model.dart';

class ChatMessageView extends ConsumerStatefulWidget {
  const ChatMessageView({super.key, required this.chat});

  final ChatEntity chat;

  @override
  ConsumerState createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends ConsumerState<ChatMessageView> {
  ChatEntity get chat => widget.chat;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(chatMessageViewModelProvider.notifier).init(chat.id);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void openChatInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, ref, child) {
            return AlertDialog(
              title: Row(
                children: [
                  Text(chat.isGroupChat ? chat.chatName : chat.users[0].fName),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              actions: [
                if (chat.isGroupChat) ...{
                  TextButton(
                    onPressed: addUserInGroupDialog,
                    child: const Text('Add user'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(chatMessageViewModelProvider.notifier)
                          .leaveGroup(chat.id);
                      Navigator.pop(context);
                      ref
                          .read(chatMessageViewModelProvider.notifier)
                          .closeView();
                    },
                    child: const Text('Leave Group'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Delete Group'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                }
              ],
              content: Column(
                children: [
                  if (chat.isGroupChat) ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: chat.users.length,
                        itemBuilder: (context, index) {
                          final user = chat.users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${ApiEndPoints.imageUrlprofile}${user.image}"),
                            ),
                            title: Text(user.fName),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void filterUsers(String query) {
    ref.read(chatMessageViewModelProvider.notifier).searchUser(query);
  }

  TextEditingController searchController = TextEditingController();

  void addUserInGroupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AuthEntity? selectedUser;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer(
              builder: (context, ref, child) {
                final chatState = ref.watch(chatMessageViewModelProvider);
                return AlertDialog(
                  title: Text('Create Group'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // search user
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: 'Search User',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            filterUsers(value);
                          },
                        ),
                        SizedBox(height: 16),
                        Text('Select Users:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ...chatState.users
                            .map((user) => CheckboxListTile(
                                  title: Text(user.fName),
                                  value: selectedUser?.userId == user.userId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedUser = user;
                                      } else {
                                        selectedUser = null;
                                      }
                                    });
                                  },
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      child: Text('Create'),
                      onPressed: () async {
                        // Implement group creation logic here
                        print(selectedUser);
                        await ref
                            .read(chatMessageViewModelProvider.notifier)
                            .addUser(chat.id, selectedUser);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatMessageViewModelProvider);
    _scrollToBottom();

    return Scaffold(
      appBar: AppBar(
        title: Text(chat.isGroupChat ? chat.chatName : chat.users[0].fName),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: openChatInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                final isCurrentUser =
                    message.sender?.email == state.user!.email;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isCurrentUser) ...[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${ApiEndPoints.imageUrlprofile}${message.sender?.image}"),
                          radius: 16,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Colors.blue[100]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              if (!isCurrentUser)
                                Text(
                                  message.sender?.fName ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              Text(message.content ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    // Implement send message logic
                    final message = _messageController.text;
                    await ref
                        .read(chatMessageViewModelProvider.notifier)
                        .sendMessage(message, chat.id);
                    if (message.isNotEmpty) {
                      // Send message
                      _messageController.clear();
                    }
                  },
                  child: const Icon(Icons.send),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
