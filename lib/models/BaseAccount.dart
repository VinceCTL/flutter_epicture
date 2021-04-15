import 'package:json_annotation/json_annotation.dart';

part 'BaseAccount.g.dart';

@JsonSerializable()
class BaseAccount {
  @JsonKey(name: 'url')
  String name;
  String bio;
  int reputation;

  BaseAccount(this.name, this.bio, this.reputation);

  factory BaseAccount.fromJson(Map<String, dynamic> json) => _$BaseAccountFromJson(json);

  Map<String, dynamic> toJson() => _$BaseAccountToJson(this);
}