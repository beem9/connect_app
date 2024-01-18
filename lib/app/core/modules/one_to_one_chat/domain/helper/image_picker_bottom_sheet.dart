import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/domain/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

mixin PickAnImageBottomSheet {
  Future showOptions(BuildContext context,
      {required String senderId, required String receiverId}) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Consumer(builder: (context, ref, child) {
              final messageProvider = ref.read(chatMessageProvider.notifier);
              return SizedBox(
                  height: context.screenHeight * 0.3,
                  width: context.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Text(
                          context.translate.photoGallery,
                          style: context.textTheme.titleSmall
                              ?.copyWith(color: MyColors.secondary_500),
                        ),
                        onTap: () {
                          context.pop();
                          messageProvider.getImageFromGallery(
                              senderId: senderId, receiverId: receiverId);
                        },
                      ),
                      GestureDetector(
                        child: Text(
                          context.translate.cameraImage,
                          style: context.textTheme.titleSmall
                              ?.copyWith(color: MyColors.secondary_500),
                        ),
                        onTap: () {
                          context.pop();
                          messageProvider.getImageFromCamera(
                              senderId: senderId, receiverId: receiverId);
                        },
                      ),
                      GestureDetector(
                        child: Text(
                          context.translate.cancel,
                          style: context.textTheme.titleSmall
                              ?.copyWith(color: MyColors.primary_500),
                        ),
                        onTap: () {
                          context.pop();
                          messageProvider.cancel();
                        },
                      ),
                    ],
                  ));
            }));
  }
}
