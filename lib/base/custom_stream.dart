import 'package:coremobiledemo/base/custom_subject.dart';
import 'package:coremobiledemo/components/loading.dart';
import 'package:coremobiledemo/config/colors_resource.dart';
import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatefulWidget {
  final CustomSubject<T> stream;
  final Widget Function(String) onError;
  final Widget Function() onWaiting;
  final Widget Function(T) onData;
  final bool isLoading;

  CustomStreamBuilder(
      {@required this.stream,
        @required this.onData,
        @required this.onError,
        @required this.onWaiting,
        isLoading})
      : assert(stream != null),
        this.isLoading = isLoading ?? true;

  @override
  State<CustomStreamBuilder<T>> createState() => _CustomStreamBuilderState<T>();
}

class _CustomStreamBuilderState<T> extends State<CustomStreamBuilder<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this.widget.stream.stream,
        builder: (context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasData) {
            if (this.widget.onData == null) {
              return Container();
            }
            return this.widget.onData(snapshot.data);
          } else if (snapshot.hasError) {
            if (this.widget.onError == null) {
              return Container();
            }
            return this.widget.onError(snapshot.error.toString());
          } else {
            if (this.widget.isLoading) {
              return Center(
                child: Loading(
                  circleColor: ColorsResource.primaryColor,
                  backgroundColor: Colors.white,
                ),
              );
            } else {
              if (this.widget.onWaiting == null) {
                return Container();
              }
              return this.widget.onWaiting();
            }
          }
        });
  }
}
