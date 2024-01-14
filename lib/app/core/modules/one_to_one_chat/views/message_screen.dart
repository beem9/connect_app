import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/core/modules/chats/domain/models/user_model.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/models/message.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/providers/chat_providers.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  final UserModel selectedUser;

  const ChatRoomPage({
    super.key,
    required this.selectedUser,
  });

  @override
  ConsumerState<ChatRoomPage> createState() => _MessagingBodyViewState();
}

class _MessagingBodyViewState extends ConsumerState<ChatRoomPage> {
  final _sendMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messagingRepo = ref.read(messagingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedUser.username),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: messagingRepo.messagesStream(
                senderId: FirebaseAuth.instance.currentUser!.uid,
                receiverId: widget.selectedUser.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return Center(
                      child:
                          Text('Error fetching messages: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final List<Message> messageList = snapshot.data ?? [];
                return ListView.builder(
                  reverse: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) =>
                      MessageBubble(message: messageList[index]),
                );
              },
            ),
          ),
          _buildMessageInput(context, widget.selectedUser.id, messagingRepo),
        ],
      ),
    );
  }

  Widget _buildMessageInput(
      BuildContext context, String userId, MessagingRepository messagingRepo) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _sendMessageController,
                decoration:
                    const InputDecoration(hintText: 'Type your message'),
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await messagingRepo
                      .sendMessage(
                    senderId: FirebaseAuth.instance.currentUser!.uid,
                    receiverId: userId,
                    message: _sendMessageController.text,
                  )
                      .whenComplete(() {
                    _sendMessageController.clear();
                  });
                } catch (e) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    context.showSnackbar(
                      'Error sending message: $e',
                    );
                  });
                }
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
