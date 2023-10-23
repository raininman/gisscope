import 'package:flutter/material.dart';
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
    final messageController = TextEditingController();
    return Scaffold(
      appBar: const Toolbar(title: AppStrings.chat),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height-115,
          child: Column(
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
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 115),
                child: Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.8 - 16),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterMessage,
                          labelText: AppStrings.enterMessage,
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
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.2 - 16),
                      child: IconButton(
                        onPressed: () {
                          provider.sendMessage(messageController.text);
                          // _messageController.text = '';
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
