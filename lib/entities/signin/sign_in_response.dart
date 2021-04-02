import 'package:json_annotation/json_annotation.dart';
import 'package:coremobiledemo/base/base_reponse.dart';
part 'sign_in_response.g.dart';

@JsonSerializable(nullable: true)
class SignInResponse extends ResponseObject<SignInModel> {

  SignInResponse({String msg, int code,  SignInModel data}) : super(msg: msg, code: code) {
    this.data = data;
  }

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

}

@JsonSerializable(nullable: true)
class SignInModel {
  String token;
  String accountId;
  String userName;
  String fullName;
  String workspace;

  SignInModel(
      {this.token,
      this.accountId,
      this.userName,
      this.fullName,
      this.workspace,});

  factory SignInModel.fromJson(Map<String, dynamic> json) => _$SignInModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}