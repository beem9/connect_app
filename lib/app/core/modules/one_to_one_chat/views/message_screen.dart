import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/core/modules/chats/domain/models/user_model.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/helper/image_picker_bottom_sheet.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/models/message.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/providers/chat_providers.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/widgets/loading_effect.dart';
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

class _MessagingBodyViewState extends ConsumerState<ChatRoomPage>
    with PickAnImageBottomSheet {
  final _sendMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messagingRepo = ref.read(messagingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedUser.username,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        iconTheme: IconThemeData(color: Colors.white), // WhatsApp green
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
                    child: Text('Error fetching messages: ${snapshot.error}'),
                  );
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
          const LoadingEffect(),
          _buildMessageInput(context, widget.selectedUser.id, messagingRepo),
        ],
      ),
    );
  }

  Widget _buildMessageInput(
      BuildContext context, String userId, MessagingRepository messagingRepo) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showOptions(context,
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  receiverId: userId);
            },
            icon: const Icon(Icons.add_a_photo),
            color: const Color.fromARGB(255, 18, 140, 126), // WhatsApp green
          ),
          Expanded(
            child: TextField(
              controller: _sendMessageController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type your message',
                hintStyle: context.textTheme.bodyText2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              ),
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
            color: const Color.fromARGB(255, 18, 140, 126), // WhatsApp green
          ),
        ],
      ),
    );
  }
}
