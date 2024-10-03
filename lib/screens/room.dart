import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/screens/chats.dart';

class Message {
  final String sender;
  final String text;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}

class RoomScreen extends StatefulWidget {
  final ChatRoom chatRoom;

  const RoomScreen({super.key, required this.chatRoom});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final List<Message> messages = [];
  final TextEditingController messagecontroller = TextEditingController();

  void sendMessage(String text) {
    final newMessage =
        Message(sender: 'You', text: text, timestamp: DateTime.now());
    setState(() {
      messages.add(newMessage);
    });
    messagecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.chatRoom.roomName),
      body: Column(
        children: [
          // 메시지 리스트 영역
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.sender),
                  subtitle: Text(message.text),
                  trailing: Text(
                    '${message.timestamp.hour}:${message.timestamp.minute}',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          // 메시지 입력창 영역
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messagecontroller,
                    decoration: const InputDecoration(
                      labelText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (messagecontroller.text.isNotEmpty) {
                      sendMessage(messagecontroller.text); // 메시지 전송
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
