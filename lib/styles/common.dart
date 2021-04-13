import 'package:eschool360/screens/Information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

final bluecolor = Colors.indigo[900];
final whitecolor = Colors.lightBlue[50];

String schoolID = "";
String username = "";
String type = "";
bool isLoggedIn = false;
String classname = "";
String videoUrl = "";

final borderRadius = BorderRadius.only(
    topRight: Radius.circular(30), topLeft: Radius.circular(30));

final buttonRadius = BorderRadius.all(Radius.circular(20));

final containerRadius = BorderRadius.all(Radius.circular(15));

final blacktext = TextStyle(fontSize: 15, color: Colors.black);

final bigblacktext = TextStyle(fontSize: 18, color: Colors.black);

final bigbluetext = TextStyle(fontSize: 18, color: Colors.indigo[900]);
final bigbluetext1 = TextStyle(fontSize: 25, color: Colors.indigo[900]);

final bluebold = TextStyle(
    fontSize: 18, color: Colors.indigo[900], fontWeight: FontWeight.bold);

final blackbold = TextStyle(
    fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

final bluetext = TextStyle(fontSize: 15, color: bluecolor);

final containerdecoration = BoxDecoration(
    /*boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(1),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],*/
    color: Colors.white,
    borderRadius: containerRadius);

String encrytion(String text) {
  String Newstr = "";
  for(var i=0;i<text.length;i++)
   switch(text[i])
       {
     case 'a':
       Newstr=Newstr+"{";
       break;
     case 'b':
       Newstr=Newstr+"}";
       break;
     case 'c':
       Newstr=Newstr+"#";
       break;
     case 'd':
       Newstr=Newstr+"~";
       break;
     case 'e':
       Newstr=Newstr+"+";
       break;
     case 'f':
       Newstr=Newstr+"-";
       break;
     case 'g':
       Newstr=Newstr+"*";
       break;
     case 'h':
       Newstr=Newstr+"@";
       break;
     case 'i':
       Newstr=Newstr+"/";
       break;
     case 'j':
       Newstr=Newstr+"\\";
       break;
     case 'k':
       Newstr=Newstr+"?";
       break;
     case 'l':
       Newstr=Newstr+"??";
       break;
     case 'm':
       Newstr=Newstr+"!";
       break;
     case 'n':
       Newstr=Newstr+"^";
       break;
     case 'o':
       Newstr=Newstr+"(";
       break;
     case 'p':
       Newstr=Newstr+")";
       break;
     case 'q':
       Newstr=Newstr+"<";
       break;
     case 'r':
       Newstr=Newstr+">";
       break;
     case 's' :
       Newstr=Newstr+"=";
       break;
     case 't':
       Newstr=Newstr+";";
       break;
     case 'u':
       Newstr=Newstr+",";
       break;
     case 'v' :
       Newstr=Newstr+"_";
       break;
     case 'w':
       Newstr=Newstr+"[";
       break;
     case 'x' :
       Newstr=Newstr+"]";
       break;
     case 'y':
       Newstr=Newstr+":";
       break;
     case 'z' :
       Newstr=Newstr+"\"";
       break;
     case ' ' :
       Newstr=Newstr+" ";
       break;
     case '.':
       Newstr=Newstr+'3';
       break;
     case ',':
       Newstr=Newstr+"1";
       break;
     case '(':
       Newstr=Newstr+'4';
       break;
     case '\"':
       Newstr=Newstr+'5';
       break;
     case ')' :
       Newstr=Newstr+"7";
       break;
     case '?' :
       Newstr= Newstr+"2";
       break;
     case '!':
       Newstr= Newstr+"8";
       break;
     case '-' :
       Newstr= Newstr+"6";
       break;
     case '%' :
       Newstr = Newstr+"9";
       break;
     case '1':
       Newstr=Newstr+"r";
       break;
     case '2':
       Newstr=Newstr+"k";
       break;
     case '3':
       Newstr=Newstr+"b";
       break;
     case '4':
       Newstr = Newstr+"e";
       break;
     case '5':
       Newstr = Newstr+"q";
       break;
     case '6':
       Newstr = Newstr+"h";
       break;
     case '7':
       Newstr = Newstr+"u";
       break;
     case '8' :
       Newstr= Newstr+"y";
       break;
     case '9':
       Newstr = Newstr+"w";
       break;
     case '0':
       Newstr = Newstr+"z";
       break;
     default:
       Newstr=Newstr+text[i];
       break;
   }


   return Newstr+'';

}
String decryt(String text){
  String Newstr = "";
  for(var i =0;i<text.length;i++)
    switch(text[i])
    {
      case '{':
        Newstr=Newstr+"A";
        break;
      case '}':
        Newstr=Newstr+"B";
        break;
      case '#':
        Newstr=Newstr+"C";
        break;
      case '~':
        Newstr=Newstr+"D";
        break;
      case '+':
        Newstr=Newstr+"E";
        break;
      case '-':
        Newstr=Newstr+"F";
        break;
      case '*':
        Newstr=Newstr+"G";
        break;
      case '@':
        Newstr=Newstr+"H";
        break;
      case '/':
        Newstr=Newstr+"I";
        break;
      case '\\':
        Newstr=Newstr+"J";
        break;
      case '?':
        Newstr=Newstr+"K";
        break;
      case '??':
        Newstr=Newstr+"L";
        break;
      case '!':
        Newstr=Newstr+"M";
        break;
      case '^':
        Newstr=Newstr+"N";
        break;
      case '(':
        Newstr=Newstr+"O";
        break;
      case ')':
        Newstr=Newstr+"P";
        break;
      case '<':
        Newstr=Newstr+"Q";
        break;
      case '>':
        Newstr=Newstr+"R";
        break;
      case '=' :
        Newstr=Newstr+"S";
        break;
      case ';':
        Newstr=Newstr+"T";
        break;
      case ',':
        Newstr=Newstr+"U";
        break;
      case '_' :
        Newstr=Newstr+"V";
        break;
      case '[':
        Newstr=Newstr+"W";
        break;
      case ']' :
        Newstr=Newstr+"X";
        break;
      case ':':
        Newstr=Newstr+"Y";
        break;
      case '\"' :
        Newstr=Newstr+"Z";
        break;
      case '1':
        Newstr=Newstr+"r";
        break;
      case '2':
        Newstr=Newstr+"k";
        break;
      case '3':
        Newstr=Newstr+"b";
        break;
      case '4':
        Newstr = Newstr+"e";
        break;
      case '5':
        Newstr = Newstr+"q";
        break;
      case '6':
        Newstr = Newstr+"h";
        break;
      case '7':
        Newstr = Newstr+"u";
        break;
      case '8' :
        Newstr= Newstr+"y";
        break;
      case '9':
        Newstr = Newstr+"w";
        break;
      case '0':
        Newstr = Newstr+"z";
        break;
      default:
        Newstr=Newstr+text[i];
        break;
    }
  return Newstr+'';
}