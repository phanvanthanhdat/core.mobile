import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/config/dimens_resource.dart';
import 'package:coremobiledemo/config/imgs_resource.dart';
import 'package:coremobiledemo/config/strings_resource.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  BackgroundContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageResource.update_info_bg),
                    fit: BoxFit.cover)
            ),
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(bottom: DimenResource.paddingContent),
                child: Text(
                  StringResource.getText("developed_by_vnptit"),
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                  left: DimenResource.paddingContent,
                  right: DimenResource.paddingContent),
              child: SingleChildScrollView(
                child: this.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundContainerForm extends StatelessWidget {
  final Widget child;

  BackgroundContainerForm({this.child});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(Radius.circular(20.0))
      ),
      child: this.child,
    );
  }
}