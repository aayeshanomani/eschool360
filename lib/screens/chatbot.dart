import 'package:eschool360/loading.dart';
import 'package:eschool360/screens/conversation.dart';
import 'package:eschool360/screens/search.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  Widget chatRoomList() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: StreamBuilder(
        stream: Database().getChatRooms(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Loading()
              : snapshot.data.documents.length == 0
                  ? Container(
                      height: 200,
                      child: Center(
                        child: Text('It seems empty in here.'),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatRoomTile(
                          username: snapshot
                              .data.documents[index].data["chatRoomId"]
                              .replaceAll("_", "")
                              .replaceAll(username, ""),
                          chatRoomId:
                              snapshot.data.documents[index].data["chatRoomId"],
                        );
                      },
                      itemCount: snapshot.data.documents.length,
                    );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text("Chat Box"),
        backgroundColor: bluecolor,
        elevation: 8,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
        backgroundColor: bluecolor,
        child: Icon(Icons.search),
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoomId;

  const ChatRoomTile({this.username, this.chatRoomId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Conversation(
                chatRoomId: chatRoomId,
                searchedname: username,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffA188A6),
                        borderRadius: BorderRadius.circular(82)),
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Text(
                        username.substring(0, 1).toUpperCase(),
                        style: bluetext,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    username,
                    style: bluetext,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3,
            )
          ],
        ),
      ),
    );
  }
}
