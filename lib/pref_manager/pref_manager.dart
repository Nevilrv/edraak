import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();
  static String emailId = "emailId";
  static String isLogin = "isLogin";
  static String userUID = "uid";
  static String userName = "userName";

  /// USER NAME
  static Future setUserName(String value) async {
    await getStorage.write(userName, value);
  }

  static getUserName() {
    return getStorage.read(userName);
  }

  /// USER EMAILID
  static Future setEmailId(String value) async {
    await getStorage.write(emailId, value);
  }

  static getEmailId() {
    return getStorage.read(emailId);
  }

  /// iSLogin

  static Future setIsLogin(bool value) async {
    await getStorage.write(isLogin, value);
  }

  static getIsLogin() {
    return getStorage.read(isLogin) ?? false;
  }

  static Future setUID(String value) async {
    await getStorage.write(userUID, value);
  }

  static getUID() {
    return getStorage.read(userUID);
  }

  static Future clearAll() async {
    await getStorage.erase();
  }

  /// MonthNameList

  static List monthName = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  /// DiseasesNameList
  static List<String> diseaseNameList = [
    "Pulmonary Tuberculosis",
    "Influenza",
    "Dengue fever",
  ];
}
