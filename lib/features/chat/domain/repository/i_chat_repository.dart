import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/chat/data/repository/chat_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../auth/domain/entity/auth_entity.dart';
import '../entity/chat_entity.dart';
import '../entity/message_entity.dart';

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  return ref.read(chatRemoteRepositoryProvider);
});

abstract class IChatRepository {
  Future<Either<Failure, List<ChatEntity>>> getChats();

  Future<Either<Failure, List<MessageEntity>>> getMessages(String id);

  Future<Either<Failure, MessageEntity>> sendMessage(
      String content, String chatId);

  Future<Either<Failure, bool>> createChat(String userId);

  Future<Either<Failure, bool>> createGroup(
      String name, List<AuthEntity> users);

  Future<Either<Failure, bool>> leaveGroup(String id);

  Future<Either<Failure, bool>> addUser(String chatId, String userId);
}
