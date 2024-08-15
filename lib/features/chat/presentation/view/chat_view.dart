import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/chat/domain/entity/chat_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoint.dart';
import '../viewmodel/chat_view_model.dart';
import 'chat_message_view.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  TextEditingController searchController = TextEditingController();

  List<User> users = [
    User(id: 1, name: 'Alice'),
    User(id: 2, name: 'Bob'),
    User(id: 3, name: 'Charlie'),
    User(id: 4, name: 'David'),
    User(id: 5, name: 'Eve'),
  ];

  final groups = [
    Group(id: 1, name: 'Group 1', members: [1, 2, 3]),
    Group(id: 2, name: 'Group 2', members: [4, 5]),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(chatViewModelProvider.notifier).fetchChat();
      await ref.read(chatViewModelProvider.notifier).getAuthUser();
    });
  }

  void filterUsers(String query) {
    ref.read(chatViewModelProvider.notifier).searchUser(query);
  }

  void createGroup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String groupName = '';
        List<AuthEntity> selectedUsers = [];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer(
              builder: (context, ref, child) {
                final chatState = ref.watch(chatViewModelProvider);
                return AlertDialog(
                  title: Text('Create Group'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Group Name',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            groupName = value;
                          },
                        ),
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
                                  value: selectedUsers.contains(user),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedUsers.add(user);
                                      } else {
                                        selectedUsers.remove(user);
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
                        print(selectedUsers);
                        await ref
                            .read(chatViewModelProvider.notifier)
                            .createGroup(groupName, selectedUsers);
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

  void openChatMessage(ChatEntity chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatMessageView(chat: chat),
      ),
    );
  }

  void createChat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AuthEntity? selectedUsers;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer(builder: (context, ref, child) {
              final chatState = ref.watch(chatViewModelProvider);
              return AlertDialog(
                title: Text('Create Chat'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
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
                      if (chatState.users.isNotEmpty)
                        ...chatState.users.map((user) => CheckboxListTile(
                              title: Text("${user.fName} ${user.lName}"),
                              value: selectedUsers?.userId == user.userId,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedUsers = user;
                                  } else {
                                    selectedUsers = null;
                                  }
                                });
                              },
                            )),
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
                    onPressed: () {
                      // Implement chat creation logic here
                      ref
                          .read(chatViewModelProvider.notifier)
                          .createChat(selectedUsers);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: createGroup,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: createChat,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(chatViewModelProvider.notifier).resetState(),
          ),
        ],
      ),
      body: Column(
        children: [
          chatState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : chatState.error != null
                  ? Center(
                      child: Text(
                        chatState.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : chatState.chats.isEmpty
                      ? const Center(child: Text('No chats found'))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: chatState.chats.length,
                            itemBuilder: (context, index) {
                              final chat = chatState.chats[index];
                              return ListTile(
                                leading: chat.isGroupChat
                                    ? CircleAvatar(
                                        child: Icon(Icons.group),
                                        backgroundColor: Colors.blue[100])
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${ApiEndPoints.imageUrlprofile}${chat.users[0].image}"),
                                      ),
                                title: chat.isGroupChat
                                    ? Text(chat.chatName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                    : chat.users[0].userId ==
                                            chatState.user?.userId
                                        ? Text(
                                            "${chat.users[1].fName} ${chat.users[1].lName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            "${chat.users[0].fName} ${chat.users[0].lName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                subtitle: Text('Last message...',
                                    style: TextStyle(color: Colors.grey)),
                                onTap: () => ref
                                    .read(chatViewModelProvider.notifier)
                                    .joinChat(chat),
                              );
                            },
                          ),
                        ),
        ],
      ),
    );
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}

class Group {
  final int id;
  final String name;
  final List<int> members;

  Group({required this.id, required this.name, required this.members});
}
