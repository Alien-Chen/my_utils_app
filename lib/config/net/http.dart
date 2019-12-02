// 对dio再次封装方便使用 且加上rap拦截器
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:my_utils_app/config/config.dart';
import 'package:my_utils_app/config/net/rap.dart';
import 'package:my_utils_app/provider/view_state.dart';
import 'package:my_utils_app/utils/platform_data_utils.dart';

Map apiHost = Config.apiHost;

class HttpGo {
  var rap = Rap();
  static final String GET = "get";
  static final String POST = "post";
  static final String PUT = "put";
  static final String DELETE = "delete";
  static final String DATA = "data";
  static final String CODE = "errorCode";
  static final baseUrl = apiHost['baseUrl'];
  //设置防抖周期为3s
  Duration durationTime = Duration(milliseconds: 200);
  Timer timer;
  Dio dio;
  static String token;
  static HttpGo _instance;

  static HttpGo getInstance() {
    if (_instance == null) {
      _instance = HttpGo();
    }
    return _instance;
  }

  HttpGo() {
    dio = new Dio(new BaseOptions(
        method: "get",
        baseUrl: baseUrl,
        connectTimeout: 100000,
        receiveTimeout: 100000,
        followRedirects: true,
        headers: {
          'token': token,
          'Content-Type': 'application/json',
        }));
    _addStartHttpInterceptor(dio);
    // 抓包使用 如果打包记得注释掉 否则网络异常
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        // proxy all request to localhost:8888
        return "PROXY 192.168.30.239:8888";
        // return "PROXY 192.168.1.100:8888";
        // return "PROXY 192.168.0.108:8888";
        // return "PROXY 192.168.31.63:8888";
        // return "PROXY 192.168.31.234:8890";
      };
    };
  }

  //get请求
  Future get(String url, {params, Function errorCallBack}) async {
    return _requstHttp(url, GET, params, errorCallBack);
  }

  //post请求
  Future post(String url, {params, Function errorCallBack}) async {
    return _requstHttp(url, POST, params, errorCallBack);
  }

  //put请求
  Future put(String url, {params, Function errorCallBack}) async {
    return _requstHttp(url, PUT, params, errorCallBack);
  }

  //delete请求
  Future delete(String url, {params, Function errorCallBack}) async {
    return _requstHttp(url, DELETE, params, errorCallBack);
  }

  Future _requstHttp(String url,
      [String method, Map params, Function errorCallBack]) async {
    Map errorStatus = {
      "network": true,
      "status": 0,
      "dioStatus": false,
      'errorMsg': ""
    };
    // 网络异常处理
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else if (connectivityResult == ConnectivityResult.none) {
      errorStatus['network'] = false;
      // _error(errorCallBack, errorStatus);
      throw ErrorType.networkError;
    }
    try {
      Response response;
      //添加请求之前的拦截器
      // _addStartHttpInterceptor(dio);
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      } else if (method == PUT) {
        if (params != null && params.isNotEmpty) {
          response = await dio.put(url, data: params);
        } else {
          response = await dio.put(url);
        }
      } else if (method == DELETE) {
        if (params != null && params.isNotEmpty) {
          response = await dio.delete(url, queryParameters: params);
        } else {
          response = await dio.delete(url);
        }
      }
      
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      return dataMap;
    } catch (exception) {
      print('error is ${exception} $url');
      throw ErrorType.defaultError;
    }
  }

  _addStartHttpInterceptor(Dio dio) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      rap.onFulfilled(options);
      PlatformDataUtils.getToken().then((value) {
        token = value;
        if (token != null) {
          options.headers['token'] = token;
        }
        // return options;
      });
    }, onResponse: (Response response) {
      Map res = json.decode(response.toString());
      // 401 token过期需要清除当前token重新登录获取token
      if (res['code'] == 401) {
        dio.clear();
      }
    }, onError: (DioError e) {
      rap.onRejected(e);
    }));
  }
}
