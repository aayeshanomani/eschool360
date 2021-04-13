import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/screens/conversation.dart';
import 'package:eschool360/screens/counselling.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'settings.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = new TextEditingController();
  QuerySnapshot searchSnapshot;

  void initiateSearch() {
    Database().getUserByName(textEditingController.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null && searchSnapshot.documents.length > 0
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                name: searchSnapshot.documents[index].data['name'],
                username: searchSnapshot.documents[index].data['username'],
              );
            })
        : Container(
            height: 283,
            child: Center(
              child: Text(
                  'Make sure the name you type matches \nthe exact name of the user \n(capital letters included).'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff32213A),
        title: Text("Search"),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                color: Color(0xffD4D6B9),
                padding: EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 27,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        onChanged: (value) {
                          initiateSearch();
                        },
                        controller: textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search by Username',
                            hintStyle: TextStyle(color: Color(0xff66717E)),
                            prefixIcon: Icon(
                              FontAwesomeIcons.keyboard,
                              color: Colors.blue[900],
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Database()
                            .getUserByName(textEditingController.text)
                            .then((value) {
                          print(value.toString());
                        });
                        initiateSearch();
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
                            "assets/images/search.jpg",
                            width: 40,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              searchList()
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String name;
  final String username;

  const SearchTile({this.name, this.username});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: blackbold,
                  ),
                  Text(
                    username,
                    style: blacktext,
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createChatroomAndStartConversation(username, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffB892FF),
                    borderRadius: BorderRadius.circular(38),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    'Message',
                    style: bluetext,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 4,
          )
        ],
      ),
    );
  }
}

createChatroomAndStartConversation(String searchedName, BuildContext context) {
  List<String> users = [username, searchedName];
  String chatRoomId = getChatRoomId(username, searchedName);
  Map<String, dynamic> chatRoomMap = {"users": users, "chatRoomId": chatRoomId};
  if (username == searchedName) {
    showAlertDialog(context, 'You cannot chat with yourself');
  } else {
    Database().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Conversation(
                  searchedname: searchedName,
                  chatRoomId: chatRoomId,
                )));
  }
}

showAlertDialog(BuildContext context, String message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
