// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) {
  return AuthModel(
    token: json['token'] as String,
    accountId: json['accountId'] as String,
    username: json['username'] as String,
    fullName: json['fullName'] as String,
      departmentName : json['departmentName'] ?? "",
    phone: json["phone"] ?? "",
      email: json["email"] ?? ""

  );
}

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'token': instance.token,
      'accountId': instance.accountId,
      'username': instance.username,
      'fullName': instance.fullName,
      'departmentName' : instance.departmentName,
  'phone': instance.phone,
  'email': instance.email,

};
