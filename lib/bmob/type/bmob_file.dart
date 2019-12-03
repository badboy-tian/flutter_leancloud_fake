import 'dart:io';

import 'package:leancloud_fake/bmob/bmob.dart';
import 'package:leancloud_fake/bmob/bmob_dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bmob_file.g.dart';


@JsonSerializable()
class BmobFile{
    @JsonKey(name: "__type")
    String type;
    String bucket;
    Metadata metaData;
    String createdAt;
    String mimeType;
    String name;
    String url;
    String objectId;
    String updatedAt;


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
        return 'BmobFile{type: $type, bucket: $bucket, metaData: $metaData, createdAt: $createdAt, mimeType: $mimeType, name: $name, url: $url, objectId: $objectId, updatedAt: $updatedAt}';
    }
}

class Metadata {
    String owner;
    int size;

    Metadata({this.owner, this.size});

    Metadata.fromJson(Map<String, dynamic> json) {
        owner = json['owner'];
        size = json['size'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['owner'] = this.owner;
        data['size'] = this.size;
        return data;
    }

    @override
    String toString() {
        return 'Metadata{owner: $owner, size: $size}';
    }
}