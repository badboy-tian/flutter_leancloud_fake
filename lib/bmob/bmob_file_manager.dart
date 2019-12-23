import 'dart:io';
import 'dart:typed_data';
import 'bmob_dio.dart';
import 'bmob.dart';
import 'package:leancloud_fake/bmob/response/bmob_handled.dart';
import 'package:mime/mime.dart';
import 'package:leancloud_fake/bmob/type/bmob_file.dart';
import 'package:leancloud_fake/bmob/response/bmob_error.dart';

class BmobFileManager {
  ///文件上传
  ///method:POST
  ///body:文本或者二进制流
  ///Content-Type:不同类型文件使用不同的值
  static Future<BmobFile> upload(File file, {String name}) async {
    String allPath = file.path;
    int indexSlash = allPath.lastIndexOf("/");
    if (file == null) {
      throw BmobError(9016, "The file is null.");
    }
    if (indexSlash == -1) {
      throw BmobError(9016, "The file's path is available.");
    }
    String fileName = allPath.substring(indexSlash, allPath.length);
    int indexPoint = fileName.indexOf(".");
    bool one = indexPoint < fileName.length - 1;
    bool two = fileName.contains(".");
    bool hasSuffix = one && two;
    if (!hasSuffix) {
      throw BmobError(9016, "The file has no suffix.");
    }

    var mime = lookupMimeType(file.path);
    String path = "${Bmob.BMOB_API_FILE_VERSION}${Bmob.BMOB_API_FILE}${name == null ? fileName : "/" + name}";
    var dataBytes = await file.readAsBytes();
    //获取所上传文件的二进制流
    Map responseData = await BmobDio.getInstance().upload(path, data: Stream.fromIterable(dataBytes.map((e) => [e])), mime: mime);
    BmobFile bmobFile = BmobFile.fromJson(responseData);
    return bmobFile;
  }

  ///文件上传
  ///method:POST
  ///body:文本或者二进制流
  ///Content-Type:不同类型文件使用不同的值
  static Future<BmobFile> uploadWithBytes(Uint8List data, String path) async {
    String allPath = path;
    int indexSlash = allPath.lastIndexOf("/");
    if (indexSlash == -1) {
      throw BmobError(9016, "The file's path is available.");
    }
    String fileName = allPath.substring(indexSlash, allPath.length);
    int indexPoint = fileName.indexOf(".");
    bool one = indexPoint < fileName.length - 1;
    bool two = fileName.contains(".");
    bool hasSuffix = one && two;
    if (!hasSuffix) {
      throw BmobError(9016, "The file has no suffix.");
    }

    var mime = lookupMimeType(path);
    String realPath = "${Bmob.BMOB_API_FILE_VERSION}${Bmob.BMOB_API_FILE}${fileName}";
    //获取所上传文件的二进制流
    Map responseData = await BmobDio.getInstance().upload(realPath, data: Stream.fromIterable(data.map((e) => [e])), mime: mime);
    BmobFile bmobFile = BmobFile.fromJson(responseData);
    return bmobFile;
  }

  ///文件删除
  ///method:delete
  static Future<BmobHandled> delete(String fileObjId) async {
    if (fileObjId == null || fileObjId.isEmpty) {
      throw BmobError(9015, "The url is null or empty.");
    }

    String path = "${Bmob.BMOB_API_FILE_VERSION}${Bmob.BMOB_API_FILE}/$fileObjId";
    Map responseData = await BmobDio.getInstance().delete(path);
    BmobHandled bmobHandled = BmobHandled.fromJson(responseData);

    return bmobHandled;
  }
}
