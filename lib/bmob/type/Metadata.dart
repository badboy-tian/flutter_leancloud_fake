import 'package:json_annotation/json_annotation.dart';

part 'Metadata.g.dart';

@JsonSerializable()
class Metadata {
  String owner;
  int size;

  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);

  @override
  String toString() {
    return 'Metadata{owner: $owner, size: $size}';
  }
}
