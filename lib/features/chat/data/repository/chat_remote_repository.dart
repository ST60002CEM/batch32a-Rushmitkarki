import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/chat/domain/repository/i_chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../auth/domain/entity/auth_entity.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/message_entity.dart';
import '../data_source/remote/chat_remote_data_source.dart';

final chatRemoteRepositoryProvider = Provider<IChatRepository>((ref) {
  return ChatRemoteRepository(ref.read(chatRemoteDataSourceProvider));
});

class ChatRemoteRepository implements IChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRemoteRepository(this.chatRemoteDataSource);

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats() {
    return chatRemoteDataSource.getChats();
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages(String id) {
    return chatRemoteDataSource.getMessages(id);
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(
      String content, String chatId) {
    return chatRemoteDataSource.sendMessage(content, chatId);
  }

  @override
  Future<Either<Failure, bool>> createChat(String userId) {
    return chatRemoteDataSource.createChat(userId);
  }

  @override
  Future<Either<Failure, bool>> createGroup(
      String name, List<AuthEntity> users) {
    return chatRemoteDataSource.createGroup(name, users);
  }

  @override
  Future<Either<Failure, bool>> leaveGroup(String id) {
    return chatRemoteDataSource.leaveGroup(id);
  }

  @override
  Future<Either<Failure, bool>> addUser(String chatId, String userId) {
    return chatRemoteDataSource.addUser(chatId, userId);
  }
}
