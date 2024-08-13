import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/chat/domain/entity/chat_entity.dart';

class MessageEntity extends Equatable {
  final String? id;
  final AuthEntity? sender;
  final String? content;
  final ChatEntity chat;

  MessageEntity(
      {required this.id,
      required this.sender,
      required this.content,
      required this.chat});

  @override
  List<Object?> get props => [id, sender, content, chat];
}
