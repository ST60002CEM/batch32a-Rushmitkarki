import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<User> users = [
    User(id: 1, name: 'Alice'),
    User(id: 2, name: 'Bob'),
    User(id: 3, name: 'Charlie'),
  ];

  List<Group> groups = [
    Group(id: 1, name: 'Friends', members: [1, 2]),
    Group(id: 2, name: 'Work', members: [2, 3]),
  ];

  TextEditingController searchController = TextEditingController();
  List<User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
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
    // Implement group creation logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Group'),
        content: const Text('Group creation functionality to be implemented.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
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
            const Text('Members:'),
            ...group.members.map((memberId) {
              User user = users.firstWhere((u) => u.id == memberId);
              return Text('- ${user.name}');
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

  void openChatMessage(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatMessageView(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat View'),
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
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length + groups.length,
              itemBuilder: (context, index) {
                if (index < filteredUsers.length) {
                  User user = filteredUsers[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                    onTap: () => openChatMessage(user),
                  );
                } else {
                  Group group = groups[index - filteredUsers.length];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.group)),
                    title: Text(group.name),
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

class ChatMessageView extends StatelessWidget {
  final User user;

  const ChatMessageView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Text('Chat messages with ${user.name}'),
      ),
    );
  }
}
