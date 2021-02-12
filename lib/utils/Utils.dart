import 'package:intl/intl.dart';

class Utils{

  static const String BASE_URL = "https://polished-sound-3002.getsandbox.com:443/";
  static const String IMAGES_URL = "loadImages";
  static const String SUCCESS_URL = "successContact";
  static const String FAILURE_URL = "failureContact";
  static const String NEWS_URL = "allNews";

  static const String _EMAIL_REG = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
  static const String _PHONE_REG = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  static const String _DATE_FORMAT_INPUT = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static const String _DATE_FORMAT_OUTPUT_FEED = "MMM dd, yyyy, hh:mm a";
  static const String _DATE_FORMAT_OUTPUT_TIME = "hh:mm a";

  static bool isValidEmail(String email) {
    return RegExp(_EMAIL_REG).hasMatch(email);
  }

  static bool isValidPhoneNumber(String phone) {
    // Null or empty string is invalid phone number
    if (phone == null || phone.isEmpty) {
      return false;
    }
    return RegExp(_PHONE_REG).hasMatch(phone);
  }

  static String getNewsFormattedDate(String time)  {
    var formattedDate = "";
    DateFormat inputTime = DateFormat(_DATE_FORMAT_INPUT);
    DateFormat sdf = DateFormat(_DATE_FORMAT_OUTPUT_FEED);
    DateFormat outputTime = DateFormat(_DATE_FORMAT_OUTPUT_TIME);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var date ;
    try {
      date = inputTime.parse(time);
    } catch (error) {
      date = now;
    }
    if (date==today) {
      formattedDate= "Today, ${outputTime.format(date)}";
    } else {
      formattedDate= sdf.format(date);
    }
    return formattedDate;
  }

}