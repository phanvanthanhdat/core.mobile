import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable(nullable: false)
class AuthModel {
  String token;
  String accountId;
  String username;
  String fullName;
  String departmentName;
  String phone;
  String email;

  AuthModel({this.token, this.accountId, this.username, this.fullName, this.departmentName, this.phone, this.email});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
