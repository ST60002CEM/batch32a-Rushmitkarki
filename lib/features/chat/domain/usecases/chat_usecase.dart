import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/chat/domain/repository/i_chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
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
}
