// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmob_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BmobFile _$BmobFileFromJson(Map<String, dynamic> json) {
  return BmobFile()
    ..type = json['__type'] as String
    ..objectId = json['objectId'] as String
    ..createdAt = json['createdAt'] as String
    ..url = json['url'] as String
    ..size = json['size']
    ..name = json['name'] as String;
}

Map<String, dynamic> _$BmobFileToJson(BmobFile instance) => <String, dynamic>{'__type': instance.type, 'objectId': instance.objectId, 'createdAt': instance.createdAt, 'url': instance.url, 'name': instance.name, 'size': instance.size};
