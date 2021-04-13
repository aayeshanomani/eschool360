class API {
  static const URL = "he2bhv1eb0.execute-api.ap-south-1.amazonaws.com";
  static const ADMIN = "prod/admin";
  static const BILL = "prod/bill";
  static const DASHBOARD = "prod/dashboard";
  static const EMPLOYEE = "prod/employee";
  static const FOOD = "prod/food";
  static const INVOICE = "prod/invoice";
  static const ISSUE = "prod/issue";
  static const LOG = "prod/log";
  static const NOTE = "prod/note";
  static const NOTICE = "prod/notice";
  static const PAYMENT = "prod/payment";
  static const REPORT = "prod/report";
  static const ROOM = "prod/room";
  static const USER = "prod/user";
  static const USERBOOK = "prod/userbook";
  static const USERBOOKED = "prod/userbooked";
  static const USERVACATE = "prod/uservacate";
  static const SIGNUP = "prod/signup";
  static const SUPPORT = "prod/support";
  static const STATUS = "prod/status";
  static const HOSTEL = "prod/hostel";

  static const RENT = "prod/rent";
  static const SALARY = "prod/salary";

  static const UPLOAD = "prod/upload";
}

const ONESIGNAL_APP_ID = "47916c74-a7c2-4819-bb65-911776d5b814";

class COLORS {
  static const RED = "#E1A1AD";
  static const GREEN = "#9AD7CB";
}

class CONTACT {
  static const TERMS_URL = "https://sites.google.com/view/cloudpg-in/terms";
  static const PRIVACY_URL = "https://sites.google.com/view/cloudpg-in/privacy";
  static const ABOUT_URL = "http://cloudpg.in/about";
  static const SUPPORT_MAIL = "rahul.cloudpg@gmail.com";
}

String mediaURL = "https://pgworld.s3.ap-south-1.amazonaws.com/";

class APPVERSION {
  static const ANDROID = "4.0";
  static const IOS = "4.0";
}

class APIKEY {
  static const ANDROID_LIVE = "T9h9P6j2N6y9M3Q8";
  static const ANDROID_TEST = "K7b3V4h3C7t6g6M7";
  static const IOS_LIVE = "b4E6U9K8j6b5E9W3";
  static const IOS_TEST = "R4n7N8G4m9B4S5n2";
}

class RAZORPAY {
  static const KEY = "rzp_live_dlraNHNbIJRuCy";
}

String adminName = "";
String adminEmailID = "";
String hostelID = "";
String admin = "0";
String adminID = "";
String hostelName = "";
List<String> amenities = new List();

Map<String, String> headers = {
  "pkgname": "com.saikrishna.cloudpg",
  "Accept-Encoding": "gzip"
};

const timeout = 10;

const defaultLimit = "25";
const defaultOffset = "0";

// status
const STATUS_400 = "400";
const STATUS_403 = "403"; // forbidden
const STATUS_500 = "500";

List<List<String>> amenityTypes = [
  ["Wifi", "1"],
  ["Bathroom", "2"],
  ["TV", "3"],
  ["AC", "4"],
  ["Power Backup", "5"],
  ["Washing Machine", "6"],
  ["Geyser", "7"],
  ["Laundry", "8"],
];

List<List<String>> billTypes = [
  ["Cable Bill", "1"],
  ["Water Bill", "2"],
  ["Electricity Bill", "3"],
  ["Food Expense", "4"],
  ["Internet Bill", "5"],
  ["Maintainance", "6"],
  ["Property Rent/Tax", "7"],
  ["Others", "8"],
];

// if you change here, change in api too
List<List<String>> paymentTypes = [
  ["Credit Card", "1"],
  ["Debit Card", "2"],
  ["Net Banking", "3"],
  ["Google Pay", "4"],
  ["PhonePe", "5"],
  ["PayTM", "6"],
  ["Cash", "7"],
  ["Others", "8"],
];

// if you change here, change in api too
List<List<String>> issueTypes = [
  ["Internet", "1"],
  ["Food", "2"],
  ["Electrical", "3"],
  ["Plumbing", "4"],
  ["Pests", "5"],
  ["Cleaning", "6"],
  ["Bed", "7"],
  ["Room", "8"],
  ["Security", "9"],
  ["Theft", "10"],
  ["Parking", "11"],
  ["TV", "12"],
  ["Appliances", "13"],
  ["Others", "14"],
];
