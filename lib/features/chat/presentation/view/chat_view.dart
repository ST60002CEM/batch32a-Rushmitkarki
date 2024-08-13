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
  List<User> filteredUsers = [];
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
    Future.microtask(() {
      ref.read(chatViewModelProvider.notifier).fetchChat();
      ref.read(chatViewModelProvider.notifier).getAuthUser();
    });
    filteredUsers = users;
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void createGroup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String groupName = '';
        List<User> selectedUsers = [];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                    SizedBox(height: 16),
                    Text('Select Users:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    ...users
                        .map((user) => CheckboxListTile(
                              title: Text(user.name),
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
                  onPressed: () {
                    // Implement group creation logic here
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Group "$groupName" created')),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showGroupDetails(Group group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(group.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Members:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...group.members.map((memberId) {
              User user = users.firstWhere((u) => u.id == memberId);
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('• ${user.name}'),
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              leaveGroup(group);
              Navigator.pop(context);
            },
            child: const Text('Leave Group'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void leaveGroup(Group group) {
    // Implement leave group logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Left group ${group.name}')),
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
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterUsers,
              decoration: const InputDecoration(
                labelText: 'Search Users',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatState.chats.length,
              itemBuilder: (context, index) {
                if (index < filteredUsers.length) {
                  User user = filteredUsers[index];
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
                            style: TextStyle(fontWeight: FontWeight.bold))
                        : chat.users[0].userId == chatState.user?.userId
                            ? Text(
                                "${chat.users[1].fName} ${chat.users[1].lName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "${chat.users[0].fName} ${chat.users[0].lName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                    subtitle: Text('Last message...',
                        style: TextStyle(color: Colors.grey)),
                    onTap: () => openChatMessage(chat),
                  );
                } else {
                  Group group = groups[index - filteredUsers.length];
                  return ListTile(
                    leading: CircleAvatar(
                        child: Icon(Icons.group),
                        backgroundColor: Colors.green[100]),
                    title: Text(group.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${group.members.length} members',
                        style: TextStyle(color: Colors.grey)),
                    onTap: () => showGroupDetails(group),
                  );
                }
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
