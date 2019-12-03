import 'dart:io';

import 'package:leancloud_fake/bmob/bmob.dart';
import 'package:leancloud_fake/bmob/bmob_dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bmob_file.g.dart';


@JsonSerializable()
class BmobFile{
    @JsonKey(name: "__type")
    String type;
    String url;
    String objectId;
    String createdAt;
    String name;
    int size;

    BmobFile(){
     type="File";
    }

    //此处与类名一致，由指令自动生成代码
    factory BmobFile.fromJson(Map<String, dynamic> json) =>
        _$BmobFileFromJson(json);


    //此处与类名一致，由指令自动生成代码
    Map<String, dynamic> toJson() => _$BmobFileToJson(this);

    @override
    String toString() {
        return 'BmobFile{type: $type, url: $url, objectId: $objectId, createdAt: $createdAt, name: $name, size: $size}';
    }
}