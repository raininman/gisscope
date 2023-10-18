import 'package:flutter/material.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/components/chat_me_item.dart';
import 'package:gisscope/components/chat_other_item.dart';
import 'package:gisscope/components/toolbar.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppRepo>();
    final _messageController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Toolbar(title: 'Chat'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final chat = provider.chats[index];
                if (chat.user.id == provider.user?.id) {
                  return ChatMeItem(chat: chat);
                }
                return ChatOtherItem(chat: chat);
              },
              itemCount: provider.chats.length,
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(
              bottom: 115,
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width * 0.8 - 16),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Enter Message",
                      labelText: "Enter Message",
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
                Container(
                  width: (MediaQuery.of(context).size.width * 0.2 - 16),
                  child: IconButton(
                    onPressed: () {
                      provider.sendMessage(_messageController.text);
                      _messageController.text = '';
                    },
                    icon: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
