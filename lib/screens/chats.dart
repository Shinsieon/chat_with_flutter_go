import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/screens/room.dart';
import 'package:my_app/utils/formatter.dart';

class ChatRoom {
  final String roomId;
  final String roomName;
  final String ownerNickname;
  final DateTime createdAt;
  final int participantCount;

  ChatRoom({
    required this.roomId,
    required this.roomName,
    required this.ownerNickname,
    required this.createdAt,
    required this.participantCount,
  });

  factory ChatRoom.fromMap(String roomId, Map<dynamic, dynamic> data) {
    return ChatRoom(
      roomId: roomId,
      roomName: data['roomName'],
      ownerNickname: data['ownerNickname'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
      participantCount: data['participantCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'ownerNickname': ownerNickname,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'participantCount': participantCount,
    };
  }
}

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final DatabaseReference _chatRoomsRef =
      FirebaseDatabase.instance.ref('chatRooms');
  List<ChatRoom> _chatRooms = [];

  @override
  void initState() {
    super.initState();
    //_fetchChatRooms();
  }

  Future<void> _fetchChatRooms() async {
    _chatRoomsRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final List<ChatRoom> loadedChatRooms = [];
        data.forEach((key, value) {
          loadedChatRooms.add(ChatRoom.fromMap(key, value));
        });
        setState(() {
          _chatRooms = loadedChatRooms;
        });
      }
    });
  }

  Future<String> _createChatRoom(String roomName) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String ownerNickname = user.displayName ?? 'Anonymous';
      final DatabaseReference newRoomRef = _chatRoomsRef.push();
      final String chatRoomId = newRoomRef.key!;
      final ChatRoom newRoom = ChatRoom(
        roomId: chatRoomId,
        roomName: roomName,
        ownerNickname: ownerNickname,
        createdAt: DateTime.now(),
        participantCount: 1,
      );
      await newRoomRef.set(newRoom.toMap());
      print('Chat room created with ID: $chatRoomId');
      return chatRoomId;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Chats'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = _chatRooms[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(chatRoom.roomName),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Owner : ${chatRoom.ownerNickname}'),
                          Text(
                              'Created at : ${Formatter.formatDateTime(chatRoom.createdAt)}'),
                          Text('Participants : ${chatRoom.participantCount}')
                        ]),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomScreen(
                            chatRoomId: chatRoom.roomId,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () async {
                  var newRoomId = await _createChatRoom('random');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomScreen(
                        chatRoomId: newRoomId,
                      ),
                    ),
                  );
                },
                child: const Text('Create New Room')),
          ),
        ],
      ),
    );
  }
}
