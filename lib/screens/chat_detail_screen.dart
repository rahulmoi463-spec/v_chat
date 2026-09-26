import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDetailScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatDetailScreen({super.key, required this.receiverId, required this.receiverName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final _supabase = Supabase.instance.client;

  void sendMessage() async {
    final myId = _supabase.auth.currentUser?.id;
    if (myId == null || _controller.text.trim().isEmpty) return;

    await _supabase.from('messages').insert({
      'sender_id': myId,
      'receiver_id': widget.receiverId,
      'content': _controller.text.trim(),
    });

    _controller.clear();
  }

  void deleteMessageForEveryone(int messageId) async {
    await _supabase.from('messages').update({'is_deleted': true}).eq('id', messageId);
  }

  @override
  Widget build(BuildContext context) {
    final myId = _supabase.auth.currentUser?.id;

    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _supabase.from('messages').stream(primaryKey: ['id']).order('created_at', ascending: false),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['sender_id'] == myId;
                    final isDeleted = msg['is_deleted'] ?? false;

                    return GestureDetector(
                      onLongPress: () {
                        if (isMe && !isDeleted) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ListTile(
                              leading: const Icon(Icons.delete, color: Colors.red),
                              title: const Text('Delete for Everyone'),
                              onTap: () {
                                Navigator.pop(context);
                                deleteMessageForEveryone(msg['id']);
                              },
                            ),
                          );
                        }
                      },
                      child: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? const Color(0xFF005C4B) : const Color(0xFF202C33),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isDeleted ? "🚫 This message was deleted" : msg['content'],
                            style: TextStyle(
                              color: isDeleted ? Colors.redAccent : Colors.white,
                              fontStyle: isDeleted ? FontStyle.italic : FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Type a message...'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Colors.teal), onPressed: sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
