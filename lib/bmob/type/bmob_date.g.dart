// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmob_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BmobDate _$BmobDateFromJson(Map<String, dynamic> json) {
  return BmobDate()
    ..iso = json['iso'] == null ? null : DateTime.parse(json['iso'] as String)
    ..type = json['__type'] as String;
}

Map<String, dynamic> _$BmobDateToJson(BmobDate instance) => <String, dynamic>{
      'iso': instance.iso?.toIso8601String(),
      '__type': instance.type,
    };
