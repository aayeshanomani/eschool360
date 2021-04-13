import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Conversation extends StatefulWidget {
  const Conversation({this.searchedname, this.chatRoomId});

  @override
  _ConversationState createState() => _ConversationState();

  final String searchedname, chatRoomId;
}

class _ConversationState extends State<Conversation> {
  TextEditingController messageController = new TextEditingController();

  Widget chatMessageList() {
    return Container(
      padding: EdgeInsets.only(bottom: 100),
      child: StreamBuilder(
        stream: Database().getConversationMessages(widget.chatRoomId),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  message: snapshot.data.documents[index].data['message'],
                  isSendByMe:
                      snapshot.data.documents[index].data['sendBy'] == username,
                );
              });
        },
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": username,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      Database().addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  Stream<QuerySnapshot> chatStream;

  @override
  void initState() {
    setState(() {
      chatStream = Database().getConversationMessages(widget.chatRoomId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7FFF7),
      appBar: AppBar(
        backgroundColor: bluecolor,
        title: Text(widget.searchedname),
      ),
      body: Container(
        child: Stack(children: [
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color(0xffD4D6B9),
              padding: EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 27,
              ),
              child: Row(
                children: [
                  Expanded(
                    //flex: 2,
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Color(0xff66717E)),
                          prefixIcon: Icon(
                            FontAwesomeIcons.keyboard,
                            color: Colors.blue[900],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      sendMessage();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xffD1CAA1),
                          const Color(0xff6E44FF)
                        ]),
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(48),
                        child: Image.asset(
                          "assets/images/sendMessage.png",
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({this.message, this.isSendByMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(left: isSendByMe?0:10, right: isSendByMe?10:0),
      alignment: isSendByMe?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: isSendByMe?[
            const Color(0xff020202),
            const Color(0xff0D324D)
          ]:[
            const Color(0xffBFD3C1),
            const Color(0xffFFF3B0)
          ]),
          borderRadius: isSendByMe? BorderRadius.only
          (
            topLeft: Radius.circular(30), 
            topRight: Radius.circular(30), 
            bottomLeft: Radius.circular(30)
          ): BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)
          )
        ),
        child: Text(message, style: TextStyle(fontSize: 17, color: isSendByMe?Colors.white:Colors.black),),
      ),
    );
  }
}
