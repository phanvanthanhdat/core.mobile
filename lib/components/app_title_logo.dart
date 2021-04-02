import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/config/imgs_resource.dart';
import 'package:coremobiledemo/utils/widget/widget.dart';

// ignore: must_be_immutable
class TitleAppLogo extends StatefulWidget {
  Color color;
  TitleAppLogo({this.color});

  @override
  _TitleAppLogoState createState() => _TitleAppLogoState();
}

class _TitleAppLogoState extends State<TitleAppLogo> {
  @override
  Widget build(BuildContext context) {
    return ImageView.asset(ImageResource.logo, scale: 1.5, color: this.widget.color ?? Colors.white,);
  }
}
