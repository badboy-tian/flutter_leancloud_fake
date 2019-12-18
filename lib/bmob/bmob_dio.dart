import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bmob.dart';

class BmobDio {
  ///网络请求框架
  Dio dio;

  ///网络请求元素
  BaseOptions options;

  ///单例
  static BmobDio instance;

  void setSessionToken(bmobSessionToken) {
    if (bmobSessionToken == null) {
      options.headers.remove("X-LC-Session");
      SharedPreferences.getInstance().then((sp) {
        sp.setString("token", "");
      });
    } else {
      SharedPreferences.getInstance().then((sp) {
        sp.setString("token", bmobSessionToken);
      });
      options.headers["X-LC-Session"] = bmobSessionToken;
    }
  }

  Future<String> getToken() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString("token");
  }

  ///无参构造方法
  BmobDio() {
    SharedPreferences.getInstance().then((sp) {
      options = new BaseOptions(
        //基地址
        baseUrl: Bmob.bmobHost,
        //连接服务器的超时时间，单位是毫秒。
        connectTimeout: 10000,
        //响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常。
        receiveTimeout: 3000,
        //请求头部
        headers: {
          "X-LC-Id": Bmob.bmobAppId,
          "X-LC-Key": Bmob.bmobMasterKey != null ? "${Bmob.bmobMasterKey},master" : Bmob.bmobRestApiKey,
          "content-type": "application/json",
        },
      );

      var token = sp.getString("token");
      if (token != null && token.length > 1) {
        options.headers["X-LC-Session"] = token;
      }

      dio = new Dio(options);
      if (Bmob.isDebug) {
        dio.interceptors.add(PrettyDioLogger(requestBody: true));
      }
    });
  }

  ///单例模式
  static BmobDio getInstance() {
    if (instance == null) {
      instance = BmobDio();
    }
    return instance;
  }

  ///GET请求
  Future<dynamic> get(path, {data, cancelToken}) async {
    var requestUrl = options.baseUrl + path;
    var headers = options.headers.toString();
    Response response = await dio.get(
      requestUrl,
      queryParameters: data,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  ///POST请求
  Future<dynamic> upload(path, {data, cancelToken, String mime}) async {
    if (mime != null) {
      //options.headers["Content-Type"] = mime;
      options.headers["content-type"] = mime;
    }
    var requestUrl = options.baseUrl + path;
    var headers = options.headers.toString();

    Response response = await dio.post(
      requestUrl,
      data: data,
      cancelToken: cancelToken,
    );

    //options.headers["Content-Type"] = "application/json";
    options.headers["content-type"] = "application/json";

    return response == null ? null : response.data;
  }

  ///POST请求
  Future<dynamic> post(path, {data, cancelToken}) async {
    var requestUrl = options.baseUrl + path;
    var headers = options.headers.toString();
    try {
      Response response = await dio.post(
        requestUrl,
        data: data,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioError catch (error) {
      throw Exception(error.response.data['error']);
    }
  }

  Future<dynamic> postCloud(name, {data, cancelToken}) {
    var path = Bmob.BMOB_API_VERSION + Bmob.BMOB_API_CLOUD + "/" + name;
    return post(path, data: data);
  }

  ///Delete请求
  Future<dynamic> delete(path, {
    data,
    cancelToken,
  }) async {
    var requestUrl = options.baseUrl + path;
    Response response = await dio.delete(requestUrl, data: data, cancelToken: cancelToken);
    return response.data;
  }

  ///Put请求
  Future<dynamic> put(path, {data, cancelToken}) async {
    var requestUrl = options.baseUrl + path;
    Response response = await dio.put(requestUrl, data: data, cancelToken: cancelToken);
    return response.data;
  }

  ///GET请求，自带请求路径
  Future<dynamic> getByUrl(requestUrl, {data, cancelToken}) async {
    var headers = options.headers.toString();
    Response response = await dio.get(
      requestUrl,
      queryParameters: data,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}
