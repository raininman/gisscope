import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gisscope/components/chat_bubble.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/data/service/auth_service.dart';
import 'package:gisscope/data/service/chat_service.dart';
import 'package:gisscope/styles/app_colors.dart';

class ChatWithUser extends StatefulWidget {
  const ChatWithUser(
      {super.key, required this.receiverEmail, required this.receiverId});
  final String receiverEmail;
  final String receiverId;

  @override
  State<ChatWithUser> createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.receiverEmail.replaceAll('@gisscope.com', '');

    return Scaffold(
      appBar: Toolbar(
        title: username,
      ),
      body: Column(children: [
        Expanded(
          child: _buildMessageList(),
        ),
        _buildUserInput()
      ]),
    );
  }

  Widget _buildMessageList() {
    String currentUserId = _authService.getCurrentuser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(currentUserId, widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _authService.getCurrentuser()!.uid;
    return ChatBubble(
      message: data['message'],
      isCurrentUser: isCurrentUser,
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "enterMessage".tr,
                labelText: "enterMessage".tr,
                labelStyle: const TextStyle(color: AppColors.white),
                border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                filled: true,
                fillColor: AppColors.fieldColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
