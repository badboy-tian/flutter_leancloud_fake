import 'package:json_annotation/json_annotation.dart';
import 'package:leancloud_fake/bmob/type/bmob_file.dart';
import 'bmob_pointer.dart';
import 'package:leancloud_fake/bmob/table/bmob_object.dart';
import 'package:leancloud_fake/bmob/bmob_utils.dart';

part 'bmob_array.g.dart';

@JsonSerializable()
class BmobArray {
  factory BmobArray.fromJson(Map<String, dynamic> json) =>
      _$BmobArrayFromJson(json);

  Map<String, dynamic> toJson() => _$BmobArrayToJson(this);

  @JsonKey(name: "__op")
  String op;

  //关联关系列表
  List<Map<String, dynamic>> objects;

  BmobArray() {
    objects = List();
  }

  //添加某个关联关系
  void add(List<BmobFile> files) {
    op = "Add";
    files.forEach((file){
      BmobPointer bmobPointer = BmobPointer();
      bmobPointer.className = BmobUtils.getTableName(file);
      bmobPointer.objectId = file.objectId;
      objects.add(bmobPointer.toJson());
    });
  }

  void AddUnique(List<BmobFile> files) {
    op = "AddUnique";
    files.forEach((file){
      BmobPointer bmobPointer = BmobPointer();
      bmobPointer.className = BmobUtils.getTableName(file);
      bmobPointer.objectId = file.objectId;
      objects.add(bmobPointer.toJson());
    });
  }

  /*
  //移除某个关联关系
  void remove(BmobObject value) {
    op = "RemoveRelation";
    BmobPointer bmobPointer = BmobPointer();
    bmobPointer.className = BmobUtils.getTableName(value);
    bmobPointer.objectId = value.objectId;
    objects.add(bmobPointer.toJson());
  }*/
}
