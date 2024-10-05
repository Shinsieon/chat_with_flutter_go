import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/screens/chats.dart';
import 'package:my_app/utils/toast.dart';

class Message {
  final String sender;
  final String text;
  final DateTime timestamp;
  final String email;

  Message({
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.email,
  });
}

class RoomScreen extends StatefulWidget {
  final String chatRoomId;

  const RoomScreen({super.key, required this.chatRoomId});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final auth = FirebaseAuth.instance;
  final List<Message> messages = [];
  final TextEditingController messagecontroller = TextEditingController();
  ChatRoom? chatRoom;

  void sendMessage(String text) async {
    final DatabaseReference chatRoomsRef =
        FirebaseDatabase.instance.ref('chatRooms/${widget.chatRoomId}/chats');
    final newMessage = Message(
        sender: auth.currentUser?.displayName ?? 'Anonymous',
        text: text,
        timestamp: DateTime.now(),
        email: auth.currentUser?.email ?? 'Anonymous');
    chatRoomsRef.push().set({
      'sender': newMessage.sender,
      'text': newMessage.text,
      'timestamp': newMessage.timestamp.millisecondsSinceEpoch,
    }).then((_) {
      ToastUtil.showToast('Message sent successfully');
    }).catchError((error) {
      ToastUtil.showToast('Failed to send message: $error');
    });
    messagecontroller.clear();
  }

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  void fetchChats() async {
    final DatabaseReference chatRoomsRef =
        FirebaseDatabase.instance.ref('chatRooms/${widget.chatRoomId}');

    final snapshot = await chatRoomsRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      chatRoom = ChatRoom.fromMap(widget.chatRoomId, data);
      print(chatRoom);
    }

    chatRoomsRef.child('chats').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      print(data);
      if (data != null) {
        final List<Message> loadedMessages = [];
        data.forEach((key, value) {
          loadedMessages.add(Message(
            sender: value['sender'],
            text: value['text'],
            timestamp: DateTime.fromMillisecondsSinceEpoch(value['timestamp']),
            email: auth.currentUser?.email ?? 'Anonymous',
          ));
        });
        setState(() {
          messages.clear();
          messages.addAll(loadedMessages);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatRoom?.roomName ?? 'Loading...'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message.email == auth.currentUser?.email;
                return Row(
                  mainAxisAlignment: isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 14.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: isCurrentUser
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.sender,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            message.text,
                            style: TextStyle(
                              color:
                                  isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            message.timestamp.toString(),
                            style: TextStyle(
                              fontSize: 10.0,
                              color: isCurrentUser
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                    controller: messagecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(messagecontroller.text);
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
