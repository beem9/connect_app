import 'dart:io';

import 'package:connect_app/app/core/modules/one_to_one_chat/domain/providers/state/message_chat_state.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatMessageStateNotifier extends StateNotifier<MessageChatState> {
  ChatMessageStateNotifier(super.state);

  final MessagingRepository _messagingRepo = MessagingRepository();
  final picker = ImagePicker();
  Future<void> sendMessage(
      {required String senderId,
      required String receiverId,
      required String message}) async {
    try {
      state = state.copyWith(isLoading: true);
      await _messagingRepo.sendMessage(
          senderId: senderId, receiverId: receiverId, message: message);
      state = state.copyWith(isLoading: false, message: "");
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// upload file
  Future uploadMediaFile({
    required File fileData,
    required String senderId,
    required String recieverId,
  }) async {
    /// using path package
    final fileName = basename(fileData.path);
    final destination = 'files/$fileName';

    try {
      state = state.copyWith(isLoading: true);

      final ref = FirebaseStorage.instance.ref(destination);
      ref.putFile(fileData).then((snapshot) async {
        // Get download URL after upload completes
        final downloadURL = await snapshot.ref.getDownloadURL();
        // Send the downloadURL as the message to the chat
        await sendMessage(
            senderId: senderId, receiverId: recieverId, message: downloadURL);
      });
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery(
      {required String senderId, required String receiverId}) async {
    try {
      state = state.copyWith(isLoading: true);
      XFile? pickedFile = await picker.pickMedia();

      /// Image picker return a XFile type which needs to be converted
      /// to a File Type
      if (pickedFile != null) {
        uploadMediaFile(
          senderId: senderId,
          recieverId: receiverId,
          fileData: File(
            pickedFile.path,
          ),
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
      // if (pickedFile == null) {}
    } catch (e) {
      state =
          state.copyWith(message: "", isLoading: false, error: e.toString());
      debugPrint(e.toString());
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera(
      {required String senderId, required String receiverId}) async {
    try {
      state = state.copyWith(isLoading: true);
      final pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 100);

      if (pickedFile != null) {
        uploadMediaFile(
          senderId: senderId,
          recieverId: receiverId,
          fileData: File(
            pickedFile.path,
          ),
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        message: "",
      );
      debugPrint(e.toString());
    }
  }

  /// clear all selected files
  void cancel() {
    state = state.copyWith(message: "");
  }
}
