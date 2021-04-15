// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseAccount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseAccount _$BaseAccountFromJson(Map<String, dynamic> json) {
  return BaseAccount(
    json['url'] as String,
    json['bio'] as String,
    json['reputation'] as int,
  );
}

Map<String, dynamic> _$BaseAccountToJson(BaseAccount instance) =>
    <String, dynamic>{
      'url': instance.name,
      'bio': instance.bio,
      'reputation': instance.reputation,
    };
