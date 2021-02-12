import 'package:json_annotation/json_annotation.dart';

part 'ImageItem.g.dart';

@JsonSerializable(nullable: false)
class ImageItem{
  @JsonKey(name: 'source',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String source;

  ImageItem({this.source});

  @override
  String toString() {
    return this.source;
  }

  factory ImageItem.fromJson(Map<String, dynamic> json) =>
      _$ImageItemFromJson(json);

  Map<String, dynamic> toJson() => _$ImageItemToJson(this);
}
