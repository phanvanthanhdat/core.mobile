// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) {
  return SignInRequest()
    ..userName = json['UserName'] as String
    ..password = json['Password'] as String
    ..source = json['Source'] as String
    ..deviceId = json['DeviceId'] as String
    ..operatingSystem = json['OperatingSystem'] as String;
}

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      'UserName': instance.userName,
      'Password': instance.password,
      'Source': instance.source,
      'DeviceId': instance.deviceId,
      'OperatingSystem': instance.operatingSystem,
    };
