import 'package:chat_app/shared/bloc/bloc.dart';
import 'package:chat_app/shared/bloc/states.dart';
import 'package:chat_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  static const String routeTitle = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getCurrentUser()
        ..getMessage(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.deepOrange,
                statusBarIconBrightness: Brightness.light,
              ),
              elevation: 10.0,
              title: Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.auth.signOut();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamBuilder(
                  stream: cubit.store.collection('messages').orderBy('time').snapshots(),
                  builder: (context, snapshot) {
                    cubit.messagesWidgets = [];
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final messages = snapshot.data!.docs.reversed;
                    for (var message in messages) {
                      final messageText = message.get('text');
                      final messageSender = message.get('sender');
                      final messageWidget = defaultMessage(
                        sender: messageSender,
                        text: messageText,
                        isMe: cubit.signedInUser.email == messageSender,
                      );
                      cubit.messagesWidgets.add(messageWidget);
                    }

                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: cubit.messagesWidgets,
                      ),
                    );
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.deepOrange,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.messageController,
                          onChanged: (value) {
                            cubit.textMessage = value;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            hintText: "Write your message here...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          cubit.sendMessage();
                          cubit.messageController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
