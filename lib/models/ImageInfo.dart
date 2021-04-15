import 'package:json_annotation/json_annotation.dart';
part 'ImageInfo.g.dart';

@JsonSerializable()
class ImageInfo {
  String type;
  String id;
  String link;
  String description;
  int width;
  int height;

  ImageInfo(this.link, this.description, this.id, this.width, this.height, this.type);

  factory ImageInfo.fromJson(Map<String, dynamic> json) => _$ImageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);
}