// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageChatState {
  final bool isLoading;
  final String message;
  final Object? error;

  MessageChatState({this.isLoading = false, this.message = "", this.error});

  MessageChatState copyWith({
    bool? isLoading,
    String? message,
    Object? error,
  }) {
    return MessageChatState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
