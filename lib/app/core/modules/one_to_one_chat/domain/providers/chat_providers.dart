import 'package:connect_app/app/core/modules/one_to_one_chat/domain/providers/controller/message_notifier.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/providers/state/message_chat_state.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagingProvider = Provider<MessagingRepository>((ref) {
  return MessagingRepository();
});
// final messageRepoInstance = MessagingRepository();
final chatMessageProvider =
    StateNotifierProvider<ChatMessageStateNotifier, MessageChatState>((ref) {
  return ChatMessageStateNotifier(MessageChatState());
});
