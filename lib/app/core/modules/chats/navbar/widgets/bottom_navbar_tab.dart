import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

abstract class BottomNavBarTabs {
  static List<BottomNavigationBarItem> tabs(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.message_outlined),
        label: context.translate.chats,
        activeIcon: const Icon(Icons.message_rounded),
      ),
      BottomNavigationBarItem(
          icon: const Icon(Icons.location_history),
          label: context.translate.location,
          activeIcon: const Icon(Icons.location_history_rounded)),
      BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: context.translate.profile,
          activeIcon: const Icon(Icons.person)),
    ];
  }
}
