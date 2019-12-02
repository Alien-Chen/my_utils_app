// 用于存储token 和 用户信息

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PlatformDataUtils {
  static final String SP_TOKEN = "token";
  static final String SP_LOGIN_STATUS = "status";

  static final String SP_NICK_NAME = "nickname";
  static final String SP_USER_AVATAR = "avatar";
  static final String SP_USER_GENDER = "gender";
  static final String SP_USER_INTRO = "intro";
  static final String SP_USER_ID = "userId";
  static final String SP_DEVICE_ID = "deviceId";
  static final String SP_VERTICAL_DISSERT = "verticalDissert";
  static final String SP_HORIZONTAL_DISSERT = "horizontalDissert";
  static final String SP_HISTORY_WORD = "historyword";
  // 保存历史记录
  static saveHistorySearchWord(String word) async {
    if(word == '' || word == null) {
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    var searchArr = await getHistorySearchWord();
    List<String> wordArr;
    if(searchArr == null || searchArr.length == 0){
      wordArr = [];
    } else {
      wordArr = searchArr;
    }
    var ariseWord = wordArr.indexOf(word);
    if(ariseWord >= 0) {
      wordArr.removeAt(ariseWord);
    } else if (wordArr.length >= 9) {
      wordArr.removeAt(wordArr.length - 1);
    }
    wordArr.insert(0, word);
    await sp.setStringList(SP_HISTORY_WORD, wordArr);
  }
  // 清除历史记录
  static Future clearHistorySearchWord() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> words = [];
    await sp.setStringList(SP_HISTORY_WORD, words);
  }
  // 获取历史记录
  static Future<List<String>> getHistorySearchWord() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(SP_HISTORY_WORD);
  }

  // 保存竖版专题获取的时间
  static saveVerticalDissert(int time) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int current = time;
    await sp.setInt(SP_VERTICAL_DISSERT, current);
  }
  // 保存竖版专题获取的时间
  static saveHorizontalDissert(int time) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int current = time;
    await sp.setInt(SP_HORIZONTAL_DISSERT, current);
  }
  // 获取竖版专题的获取时间
  static getVerticalDissert() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int time = sp.getInt(SP_VERTICAL_DISSERT);
    return time;
  }
  // 获取横版专题的获取时间
  static getHorizontalDissert() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int time = sp.getInt(SP_HORIZONTAL_DISSERT);
    return time;
  }
  // 保存用户登录信息，data中包含token
  static saveLoginInfo(Map data) async {
    if(data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String token = data['token'];
      await sp.setString(SP_TOKEN, token);
      // bool status = data['status'];
      // await sp.setBool(SP_LOGIN_STATUS, status);
    }
  }

  // 清除登录信息
  static Future clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // await sp.setString(SP_TOKEN, "");
    await sp.setString(SP_NICK_NAME, "");
    await sp.setInt(SP_USER_GENDER, 0);
    await sp.setString(SP_USER_INTRO, "");
    await sp.setInt(SP_USER_ID, 0);
    await sp.setString(SP_USER_AVATAR, "http://res.explosive.feibo.com/FrKYY5-WYgwKETMl9BV3OsmZ3Bc0");
    // await sp.setBool(SP_LOGIN_STATUS, false);
  }

  // 清除登录信息
  static clearLoginInfoNoLoginOut() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // await sp.setString(SP_TOKEN, "");
    await sp.setString(SP_NICK_NAME, "");
    await sp.setInt(SP_USER_GENDER, 0);
    await sp.setString(SP_USER_INTRO, "");
    await sp.setString(SP_USER_AVATAR, "http://res.explosive.feibo.com/FrKYY5-WYgwKETMl9BV3OsmZ3Bc0");
    // await sp.setBool(SP_LOGIN_STATUS, false);
  }

  // 是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(SP_LOGIN_STATUS);
    return b != null && b;
  }

  // 获取token
  static Future<String> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_TOKEN);
  }

  // 获取设备id
  static Future<String> getDevice() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_DEVICE_ID);
  }
}