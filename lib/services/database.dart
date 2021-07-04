import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/styles/common.dart';

class Database {
  Future<bool> checkSchool(String id) async {
    final result = await Firestore.instance.collection(id).getDocuments();
    return result.documents.isEmpty;
  }

  Future<bool> checkUsername(String username) async {
    final result = await Firestore.instance
        .collection(schoolID)
        .where('username', isEqualTo: username)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }

  Future<bool> checkPassword(String username, String password) async {
    final result = await Firestore.instance
        .collection(schoolID)
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }

  Future<bool> checkStudent(String username, String type) async {
    final result = await Firestore.instance
        .collection(schoolID)
        .where('username', isEqualTo: username)
        .where('type', isEqualTo: type)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }

  getClass() {
    return Firestore.instance
        .collection(schoolID)
        .where('username', isEqualTo: username)
        .getDocuments()
        .then((value) => value.documents[0].data['class']);
  }

  getDocument() {
    return Firestore.instance
        .collection(schoolID)
        .where('username', isEqualTo: username)
        .snapshots();
  }

  addHomework(String _value, String _value1, String note) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('diary')
        .document(_value)
        .setData({
      "subject": _value1,
      "note": note,
      "class": _value
      //currently assuming teacher teaches
    }, merge: true //only one subject to a particular class
            );
  }

  updatePassword(String username, String newPassword) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .setData({"password": newPassword}, merge: true);
  }

  addTimetable(String field, String subject, String _value) {
    Firestore.instance
        .collection(schoolID)
        .document('timetable')
        .collection('timetable')
        .document(_value)
        .setData({field: subject}, merge: true);
  }

  addStudent(String username, Map data) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .setData(data, merge: true);
  }

  delHomework(String std) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('diary')
        .document(std)
        .delete();
  }

  getSyllabusDoc() {
    return Firestore.instance
        .collection(schoolID)
        .where('syllabusExists', isEqualTo: true)
        .snapshots();
  }

  getSyllabusTeacher(String docId, String exam) {
    return Firestore.instance
        .collection(schoolID)
        .document(docId)
        .collection('syllabus')
        .document(exam)
        .snapshots();
  }

  getSyllabus(String docId, String exam, String sysClass) {
    print(docId);
    return Firestore.instance
        .collection(schoolID)
        .document('syllabus')
        .collection('syllabus')
        .document(exam)
        .collection(sysClass)
        .snapshots();
  }

  getStudentSyllabus(String _value) {
    return Firestore.instance
        .collection(schoolID)
        .document('syllabus')
        .collection('syllabus')
        .document(_value)
        .collection(classname)
        .snapshots();
  }

  Future<bool> checkSyllabus(String docId, String exam, String sysClass) async {
    final result = await Firestore.instance
        .collection(schoolID)
        .document(docId)
        .collection('syllabus')
        .document(exam)
        .collection(sysClass)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }

  addSyllabus(String exam, String classname, String sub,
      Map<String, dynamic> syllabus) {
    Firestore.instance
        .collection(schoolID)
        .document('syllabus')
        .collection('syllabus')
        .document(exam)
        .collection(classname)
        .document(sub)
        .setData(syllabus);
  }

  getStudents() {
    print(schoolID);
    return Firestore.instance
        .collection(schoolID)
        .where('type', isEqualTo: 'student')
        .snapshots();
  }

  addMarks(
      String username, String exam, String sub, Map<String, dynamic> marks) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('marks')
        .document(exam)
        .collection('marks')
        .document(sub)
        .setData(marks, merge: true);
  }

  addDiary(String username1, String subject, String note) {
    Firestore.instance
        .collection(schoolID)
        .document(username1)
        .collection('diary')
        .document(subject)
        .setData({"note": note, "subject": subject, "submitted": false},
            merge: true);
  }

  addPdfDiary(String username1, String subject, Map data) {
    Firestore.instance
        .collection(schoolID)
        .document(username1)
        .collection('Pdfdiary')
        .document(subject)
        .setData(data, merge: true);
  }

  getPdfDiary() {
    return Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('Pdfdiary')
        .snapshots();
  }

  markAttendance(String username, Map<String, dynamic> attendance) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('attendance')
        .document(attendance['date'])
        .setData(attendance, merge: true);
  }

  getAttendance() {
    return Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('attendance')
        .snapshots();
  }

  getMarks(String username, String exam, String sub) {
    return Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('marks')
        .document(exam)
        .collection(sub)
        .snapshots();
  }

  getDiary() {
    return Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('diary')
        .snapshots();
  }

  submitHomeworkDiary(String subject, Map data) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('diary')
        .document(subject)
        .setData(data, merge: true);
  }

  submitHomeworkPdfDiary(String subject, Map data) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('Pdfdiary')
        .document(subject)
        .setData(data, merge: true);
  }

  getVideoLectures(String c) {
    return Firestore.instance
        .collection(schoolID)
        .document('videos')
        .collection(c)
        .snapshots();
  }

  uploadVideoLectures(String c, Map<String, dynamic> data) {
    Firestore.instance
        .collection(schoolID)
        .document('videos')
        .collection(c)
        .document()
        .setData(data, merge: true);
  }

  saveLink(String link, String sub, String c, String topic) {
    Firestore.instance
        .collection(schoolID)
        .document('classes')
        .collection(c)
        .document(sub)
        .setData({'room': link, 'subject': sub, 'topic': topic}, merge: true);
  }

  getLink() {
    return Firestore.instance
        .collection(schoolID)
        .document('classes')
        .collection(classname)
        .snapshots();
  }

  delLink(String sub, String c) {
    Firestore.instance
        .collection(schoolID)
        .document('classes')
        .collection(c)
        .document(sub)
        .delete();
  }

  getTimetable(String _value) {
    return Firestore.instance
        .collection(schoolID)
        .document('timetable')
        .collection('timetable')
        .document(_value)
        .snapshots();
  }

  information() {
    return Firestore.instance
        .collection(schoolID)
        .document(username)
        .collection('information')
        .snapshots();
  }

  putInformation(Map<String, dynamic> info) {
    Firestore.instance
        .collection(schoolID)
        .document(username)
        .setData(info, merge: true);
  }

  getUserByName(String name) async {
    return await Firestore.instance
        .collection(schoolID)
        .where('name', isEqualTo: name)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection(schoolID)
        .document('chatroom')
        .collection('chatroom')
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection(schoolID)
        .document('chatroom')
        .collection('chatroom')
        .document(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChatRooms() {
    return Firestore.instance
        .collection(schoolID)
        .document('chatroom')
        .collection('chatroom')
        .where("users", arrayContains: username)
        .snapshots();
  }

  getConversationMessages(String chatRoomId) {
    return Firestore.instance
        .collection(schoolID)
        .document('chatroom')
        .collection('chatroom')
        .document(chatRoomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }
}

teacherdiarygetdata() {
  var fs = Firestore.instance;
  return fs
      .collection(schoolID)
      .document(username)
      .collection('diary')
      .snapshots();
}
