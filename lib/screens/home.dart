import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/routes.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(title: 'Chatter'),
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
                    Text('Created at : ${formatDateTime(chatRoom.createdAt)}'),
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == AppRoutes.signInScreen) {
      return const SizedBox
          .shrink(); // Return an empty widget if on the login screen
    }

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      onTap: (index) {
        // Handle navigation based on the selected index
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.homeScreen);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.homeScreen);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.homeScreen);
            break;
        }
      },
    );
  }
}
