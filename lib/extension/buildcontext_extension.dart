
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// tạo thêm mở rộng thay vì dùng static function
extension BuildContextExtension on BuildContext {
  T getProvider<T>() {
    return Provider.of<T>(this, listen: false);
  }
}