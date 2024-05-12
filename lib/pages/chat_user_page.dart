import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/components/user_tile.dart';
import 'package:gisscope/data/service/auth_service.dart';
import 'package:gisscope/data/service/chat_service.dart';
import 'package:gisscope/pages/chat_with_user.dart';

class ChatUserPage extends StatelessWidget {
  ChatUserPage({super.key});

  final _chatService = ChatService();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "chats".tr,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentuser()!.email) {
      return UserTile(
        text: userData["email"].replaceAll('@gisscope.com', ''),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatWithUser(receiverEmail: userData["email"], receiverId: userData["uid"],)));
        },
      );
    } else {
      return Container();
    }
  }
}
