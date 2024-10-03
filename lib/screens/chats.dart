import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/screens/room.dart';
import 'package:my_app/utils/formatter.dart';

class ChatRoom {
  final String roomName;
  final String ownerNickname;
  final DateTime createdAt;
  final int participantCount;
  ChatRoom(
      {required this.roomName,
      required this.ownerNickname,
      required this.createdAt,
      required this.participantCount});
}

class ChatsScreen extends StatelessWidget {
  final List<ChatRoom> chatRooms = [
    ChatRoom(
      roomName: 'Flutter Devs',
      ownerNickname: 'JohnDoe',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      participantCount: 5,
    ),
  ];
  ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Chats'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
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
                          builder: (context) => RoomScreen(chatRoom: chatRoom),
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
                onPressed: () {
                  var newRoom = ChatRoom(
                    roomName: 'random',
                    ownerNickname: auth.currentUser?.displayName ?? 'guest',
                    createdAt: DateTime.now(),
                    participantCount: 1,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomScreen(
                        chatRoom: newRoom,
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
