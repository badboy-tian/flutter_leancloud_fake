// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmob_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BmobFile _$BmobFileFromJson(Map<String, dynamic> json) {
  return BmobFile()
    ..type = json['__type'] as String
    ..bucket = json['bucket'] as String
    ..metaData = json['metaData'] == null
        ? null
        : Metadata.fromJson(json['metaData'] as Map<String, dynamic>)
    ..createdAt = json['createdAt'] as String
    ..mimeType = json['mimeType'] as String
    ..name = json['name'] as String
    ..url = json['url'] as String
    ..objectId = json['objectId'] as String
    ..updatedAt = json['updatedAt'] as String;
}

Map<String, dynamic> _$BmobFileToJson(BmobFile instance) => <String, dynamic>{
      '__type': instance.type,
      'bucket': instance.bucket,
      'metaData': instance.metaData,
      'createdAt': instance.createdAt,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'url': instance.url,
      'objectId': instance.objectId,
      'updatedAt': instance.updatedAt,
    };
