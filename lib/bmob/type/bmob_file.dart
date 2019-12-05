import 'dart:io';

import 'package:leancloud_fake/bmob/bmob.dart';
import 'package:leancloud_fake/bmob/bmob_dio.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Metadata.dart';

part 'bmob_file.g.dart';


@JsonSerializable()
class BmobFile{
    @JsonKey(name: "__type")
    String type;
    String bucket;
    Metadata metaData;
    String createdAt;
    String mime_type;
    String name;
    String url;
    String objectId;
    String updatedAt;
    String key;
    String provider;


    BmobFile(){
     type="File";
    }

    //此处与类名一致，由指令自动生成代码
    factory BmobFile.fromJson(Map<String, dynamic> json) =>
        _$BmobFileFromJson(json);


    //此处与类名一致，由指令自动生成代码
    Map<String, dynamic> toJson() => _$BmobFileToJson(this);
}

