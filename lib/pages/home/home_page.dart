import 'package:coremobiledemo/components/raised_buttom_custom.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/pages/home/home_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/base/page.dart';
import 'home_presenter.dart';


class MyHomePage extends StatefulWidget {
  static const routeName = 'home';

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends BaseState<HomePresenter, MyHomePage>
    with SingleTickerProviderStateMixin
    implements HomeView {


  @override
  void init() {
    presenter = HomePresenter(context: context, view: this,);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(presenter.titleApp),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: presenter.dataUserStream,
                builder: (context, AsyncSnapshot<SignInModel> snapshot) {
                  if(snapshot.hasData){
                    SignInModel model = snapshot.data;
                    return Text(model.fullName);
                  }else{
                    return SizedBox();
                  }
                }
              ),
              RaisedButtonCustom(
                  text: presenter.logoutButtonTitle,
                  onPressed: presenter.logout,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> hideLoading() async {
    return await progressDialogLoading.hide();
  }

  @override
  Future<bool> showLoading() async {
    return await progressDialogLoading.show();
  }

  @override
  void showToast(String msg) {
    toastMessage(msg: msg ?? "");
  }

}

