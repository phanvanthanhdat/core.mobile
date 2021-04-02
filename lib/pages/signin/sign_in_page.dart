import 'package:coremobiledemo/pages/signin/sign_in_interface.dart';
import 'package:coremobiledemo/pages/signin/sign_in_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/base/page.dart';
import 'package:coremobiledemo/components/app_title_logo.dart';
import 'package:coremobiledemo/components/container/background_container.dart';
import 'package:coremobiledemo/components/raised_buttom_custom.dart';
import 'package:coremobiledemo/components/text_input_form_field.dart';
import 'package:coremobiledemo/config/colors_resource.dart';
import 'package:coremobiledemo/config/dimens_resource.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = 'SignIn';

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends BaseState<SignInPresenter, SignInPage>
    implements SignInView {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void init() {
    // khởi tạo presenter
    presenter = SignInPresenter(context: context, view: this);
    usernameController.addListener(() {
      presenter.onChangeUserName(usernameController.text);
    });
    passwordController.addListener(() {
      presenter.onChangePass(passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(presenter.titleApp),
      ),
      body: InkWell(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: BackgroundContainer(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 5.0, top: 10),
                  child: TitleAppLogo(
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: DimenResource.paddingContent,
                      bottom: DimenResource.paddingContent),
                  alignment: Alignment.center,
                  child: Text(
                    presenter.titleAppContent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorsResource.textColorUpdateInfo,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                BackgroundContainerForm(
                  child: Container(
                    child: Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _titleForm(
                            content: presenter.loginButtonTitle.toUpperCase(),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        _titleForm(
                            content: presenter.signInPlease.toUpperCase(),
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          children: <Widget>[
                            StreamBuilder(
                              stream: presenter.usernameErrorObserver,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return TextInputFormField(
                                  keyboardType: TextInputType.text,
                                  prefixIcon: Icon(Icons.person),
                                  hintText: presenter.signInUsername,
                                  focusNode: presenter.usernameFocusNode,
                                  textEditingController: usernameController,
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  onSubmitted: (_) =>
                                      presenter.passwordFocusNode.requestFocus(),
                                );
                              },
                            ),
                            StreamBuilder(
                              stream: presenter.passwordErrorObserver,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return TextInputFormField(
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    prefixIcon: Icon(Icons.vpn_key),
                                    hintText: presenter.signInPassword,
                                    focusNode: presenter.passwordFocusNode,
                                    textEditingController: passwordController,
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
                                    onSubmitted: (_) => presenter.login());
                              },
                            ),
                          ],
                        ),
                        Container(
                          child: RaisedButtonCustom(
                            text: presenter.loginButtonTitle.toUpperCase(),
                            onPressed: () {
                              presenter.login();
                            },
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                SizedBox(
                  height: DimenResource.marginContent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleForm({String content, double fontSize, FontWeight fontWeight}) {
    return Container(
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  Future<void> showLoginFail() async {
    await this.showPopupWithAction(presenter.signInFail, actions: null);
  }

  @override
  Future<bool> hideLoading() async {
    await progressDialogLoading.hide();
    return true;
  }

  @override
  Future<bool> showLoading() async {
    await progressDialogLoading.show();
    return true;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
