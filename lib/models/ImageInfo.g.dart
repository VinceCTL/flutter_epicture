// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) {
  return ImageInfo(
    json['link'] as String,
    json['description'] as String,
    json['id'] as String,
    json['width'] as int,
    json['height'] as int,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'link': instance.link,
      'description': instance.description,
      'width': instance.width,
      'height': instance.height,
    };
