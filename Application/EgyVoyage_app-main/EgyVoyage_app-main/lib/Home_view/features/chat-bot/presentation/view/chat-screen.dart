import "dart:convert";
import "dart:io";
import "package:egyvoyage/Home_view/features/chat-bot/presentation/view/widget/SendRequestToGemini.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

import "../data/chat_model.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String id ='ChatScreen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class MyColors {
  static Color color =  Color(0xff283618);
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> chatList = [];
  final TextEditingController controller = TextEditingController();
  File? image;
  bool showImageContainer = false; // Track if the image container is visible

  // Function to toggle the visibility of the image container
  void toggleImageContainerVisibility() {
    setState(() {
      showImageContainer = !showImageContainer;
    });
  }

  // Function to clear the selected image and hide the image container
  void clearImage() {
    setState(() {
      image = null;
      showImageContainer = false;
    });
  }


  void onSendMessage() async {
    late ChatModel model;

    if (image == null) {
      model = ChatModel(isMe: true, message: controller.text);
    } else {
      final imageBytes = await image!.readAsBytes();
      String base64EncodedImage = base64Encode(imageBytes);

      model = ChatModel(
        isMe: true,
        message: controller.text,
        base64EncodedImage: base64EncodedImage,
      );
    }

    // Clear text and image before sending
    controller.clear(); // Clear text field
    image = null; // Remove selected image

    setState(() {
      chatList.insert(0, model);
    });

    final geminiModel = await sendRequestToGemini(model);

    setState(() {
      chatList.insert(0, geminiModel);
    });
  }

  void selectImage() async {
    final picker = await ImagePicker.platform.getImage(source: ImageSource.gallery);

    if (picker != null) {
      setState(() {
        image = File(picker.path);
      });
    }
  }

  void clearChat() {
    setState(() {
      chatList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFAF5EB),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/photo/back-chat/back1.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: MyColors.color),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "EgyVoyage Bot",
                        style: TextStyle(
                          fontFamily: 'pacifico',
                          fontSize: 20,
                          color: MyColors.color,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            clearChat();
                          },
                          icon: Icon(Icons.update, size: 24, color: MyColors.color),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      bool isMe = chatList[index].isMe;
                      Color bubbleColor = isMe
                          ? const Color(0xffD6BE7F).withOpacity(.7)
                          : const Color(0xffb69c78).withOpacity(1);
                      Color textColor = isMe ? Colors.black : Colors.black;
                      CrossAxisAlignment crossAxisAlignment =
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: bubbleColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: crossAxisAlignment,
                            children: [
                              if (chatList[index].base64EncodedImage != null)
                                Image.memory(
                                  base64Decode(chatList[index].base64EncodedImage!),
                                  height: 300,
                                  width: double.infinity,
                                ),
                              SelectableText(
                                chatList[index].message,
                                style: TextStyle(color: textColor, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90.0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: MyColors.color.withOpacity(.6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: MyColors.color.withOpacity(.001),
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                clearImage();
                              },
                              icon: const Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            style: TextStyle(color: MyColors.color),
                            controller: controller,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfffefae0).withOpacity(.8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(24),
                                  right: Radius.circular(24),
                                ),
                                borderSide: BorderSide(
                                  color: MyColors.color,
                                ),
                              ),
                              hintStyle: TextStyle(color: MyColors.color),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  selectImage();
                                  controller.clear();
                                },
                                icon: Icon(
                                  Icons.upload_file,
                                  color: MyColors.color,
                                  size: 40,
                                ),
                              ),
                              hintText: "Message",
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            onSendMessage();
                            controller.clearComposing();
                          },
                          icon: Icon(
                            Icons.send,
                            color: MyColors.color,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
