import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _ChatView(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8LNTxHlp5sBzcAnhtz2qxXvROZlhjcw1N4kFddXRefXRI3uospyaLnzzjHF6PU_iUFlI&usqp=CAU'),
        ),
      ),
      title: const Text('El Chat'),
      centerTitle: false,
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];
                    return message.fromWho == FromWho.hers
                        ? HerMessageBubble(
                            message: message,
                          )
                        : MyMessageBubble(
                            message: message,
                          );
                  }),
            ),
            MessageFieldBox(
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
