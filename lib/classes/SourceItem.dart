import 'package:json_annotation/json_annotation.dart';

part 'SourceItem.g.dart';

@JsonSerializable(nullable: false)
class SourceItem{
  @JsonKey(name: 'id',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String id;
  @JsonKey(name: 'name',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String name;

  SourceItem({this.id, this.name});

  factory SourceItem.fromJson(Map<String, dynamic> json) =>
      _$SourceItemFromJson(json);

  Map<String, dynamic> toJson() => _$SourceItemToJson(this);
}