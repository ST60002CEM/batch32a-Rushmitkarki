import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/chat/domain/repository/i_chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../auth/domain/entity/auth_entity.dart';
import '../entity/chat_entity.dart';
import '../entity/message_entity.dart';

final chatUsecaseProvider = Provider(
  (ref) => ChatUsecase(
    ref.read(chatRepositoryProvider),
  ),
);

class ChatUsecase {
  final IChatRepository repository;

  ChatUsecase(this.repository);

  Future<Either<Failure, List<ChatEntity>>> getChats() {
    return repository.getChats();
  }

  Future<Either<Failure, List<MessageEntity>>> getMessages(String id) {
    return repository.getMessages(id);
  }

  Future<Either<Failure, MessageEntity>> sendMessage(
      String content, String chatId) {
    return repository.sendMessage(content, chatId);
  }

  Future<Either<Failure, bool>> createChat(String userId) {
    return repository.createChat(userId);
  }

  Future<Either<Failure, bool>> createGroup(
      String name, List<AuthEntity> users) {
    return repository.createGroup(name, users);
  }

  Future<Either<Failure, bool>> leaveGroup(String id) {
    return repository.leaveGroup(id);
  }

  Future<Either<Failure, bool>> addUser(String chatId, String userId) {
    return repository.addUser(chatId, userId);
  }
}
