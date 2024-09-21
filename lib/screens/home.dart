import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/screens/room.dart';

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

// 날짜 포맷팅 함수
String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd – HH:mm').format(dateTime);
}

class HomeScreen extends StatelessWidget {
  final List<ChatRoom> chatRooms = [
    ChatRoom(
      roomName: 'Flutter Devs',
      ownerNickname: 'JohnDoe',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      participantCount: 5,
    ),
    ChatRoom(
      roomName: 'Dart Beginners',
      ownerNickname: 'JaneSmith',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      participantCount: 10,
    ),
    ChatRoom(
      roomName: 'Tech Talks',
      ownerNickname: 'AlexBrown',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      participantCount: 3,
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String nickname =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'Guest';
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome $nickname'),
        ),
        body: ListView.builder(
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
                              'Created at : ${formatDateTime(chatRoom.createdAt)}'),
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
                  ));
            }));
  }
}
