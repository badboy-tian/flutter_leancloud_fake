// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmob_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BmobArray _$BmobArrayFromJson(Map<String, dynamic> json) {
  return BmobArray()
    ..op = json['__op'] as String
    ..objects = (json['objects'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList();
}

Map<String, dynamic> _$BmobArrayToJson(BmobArray instance) => <String, dynamic>{
      '__op': instance.op,
      'objects': instance.objects,
    };
