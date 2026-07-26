enum ChatSender {
  user,
  bot,
}

class ChatMessage {
  final String id;
  final String message;
  final ChatSender sender;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.sender,
    required this.createdAt,
  });

  bool get isUser => sender == ChatSender.user;
}
