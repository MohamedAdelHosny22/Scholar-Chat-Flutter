import 'package:flutter/material.dart';
import 'package:scholar_chat_app/constants/constants.dart';
import 'package:scholar_chat_app/models/message_model.dart';
import 'package:scholar_chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat_app/widgets/chat_bubble_for_friend.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = "ChatScreen";

  final _controller = ScrollController();

  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              MessageModel.fromJson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>,
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              elevation: 10,
              shadowColor: Colors.grey,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/scholar.png", height: 50),
                  const Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubbleForFriend(
                            message: messagesList[index],
                          );
                    },
                    physics: BouncingScrollPhysics(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 30,
                    left: 16,
                    right: 16,
                  ),
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        kId: email,
                      });
                      messageController.clear();
                      _controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: "Type a message",
                      suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}


