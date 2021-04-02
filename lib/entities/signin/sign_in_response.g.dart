// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) {
  return SignInResponse(
    msg: json['msg'] as String,
    code: 1,
    data: SignInModel.fromJson(json),
  );
}

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) {
  return SignInModel(
    token: json['token'] as String,
    accountId: json['accountId'] as String,
    userName: json['userName'] as String,
    fullName: json['fullName'] as String,
    workspace: json['workspace'] as String,
  );
}

Map<String, dynamic> _$SignInModelToJson(SignInModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'accountId': instance.accountId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'workspace': instance.workspace,
    };