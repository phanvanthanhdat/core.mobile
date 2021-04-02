import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:coremobiledemo/utils/encrypt_utils.dart';

part 'sign_in_request.g.dart';

@JsonSerializable(nullable: true)
class SignInRequest {
  String userName;
  String password;
  String source = 'mobile';
  String deviceId;
  String operatingSystem;

  SignInRequest({String userName, String password, String deviceId})
      : this.userName = userName,
        this.password = EncryptUtils.encryptPassword(password),
        this.operatingSystem =
            Platform.isIOS ? 'i_flutter' : Platform.isAndroid ? 'a_flutter' : 'unknown',
        this.deviceId = deviceId;

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}
