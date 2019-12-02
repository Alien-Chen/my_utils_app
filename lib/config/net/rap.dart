import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_utils_app/config/config.dart';
Map apiHost = Config.apiHost;
class Rap {

  covertUrlToRelatiive(url) {
    String baseUrl;
    if(url is RegExp) {
      return url;
    }
    if(!(url is String) || url.isEmpty) {
      throw FormatException('Illegal url :$url');
    }
    if(url.startsWith("http://")) {
      baseUrl = url.substring(url.indexOf('/', 7) + 1);
    } else if(url.startsWith("https://")) {
      baseUrl = url.sustring(url.indexOf('/', 8) +1);
    }
    if(url.indexOf('/') != 0) {
      baseUrl = '/$url';
    }
    return baseUrl;
  }
  

  static String rapUrl = apiHost['rapConfig']['rapUrl'];
  static int rapMode = apiHost['rapConfig']['rapMode'];
  static List rapWhiteList = apiHost['rapConfig']['rapWhiteList'];
  static List rapBlackList = apiHost['rapConfig']['rapBlackList'];
  static List rapFilterHeaders = apiHost['rapConfig']['rapFilterHeaders'];
  static List rapFilterMethods = apiHost['rapConfig']['rapFilterMethods'];


  isRap(url) {
    bool isRap = false;
    if(rapMode == 0) {
      isRap = false;
    } else if(rapMode == 1) {
      isRap = true;
    } else if(rapMode == 2 || rapMode == 3) {
      bool blackMode = rapMode == 2;
      isRap = blackMode;
      List list = blackMode ? rapBlackList : rapWhiteList;
      for(int i = 0 ; i < list.length; i+=1) {
        String o = covertUrlToRelatiive(list[i]);
        if((o is String && url.toString().indexOf(o) >= 0)) {
          isRap = !blackMode;
          break;
        }
      }
    }
    return isRap;
  }

  onFulfilled(RequestOptions temp) {
    var config = temp;
    if(this.isRap(config.uri)) {
      config.baseUrl = rapUrl;
      // config.uri = config.uri.toString().replaceAll(config.baseUrl, rapUrl);
      
      // 处理RAP上不支持Header
      // if(config.headers != null  && rapFilterHeaders.length > 0) {
        // rapFilterHeaders.forEach((value) {
        //   config.headers.common.remove(value);
        // });
        // 删除 config.headers.common.Authorization Rap上不需要Authorzation字段， 否则报错
      // }
    }

    // 处理RAP上不支持的Method
    if (rapFilterMethods.length != 0 && rapFilterMethods.length > 0) {
      rapFilterMethods.forEach((value) {
        if(config.method == value) {
          config.method = 'post';
        }
      });
    }
    return config;
  }

  onResult(res) {
    if(this.isRap(res.config.uri)) {
      return res.data;
    }

    if(!this.isRap(res.config.uri)) {
      if(int.parse(res.data.retType) == 1) {
        return jsonDecode(res.data.data.result);
      }
      if(int.parse(res.data.retType) == -1) {
        Future.error(res.data);
      }
    }
  }

  onRejected(error) {
    return Future.error(error);
  }

}