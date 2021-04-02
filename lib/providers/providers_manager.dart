
import 'package:coremobiledemo/observer/action_back_android.dart';
import 'package:coremobiledemo/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../observer/force_logout.dart';
// chức các phần dùng chung cần khơi tạo sử dụng cả project
class ProviderManager {
  List<SingleChildWidget> generateProvider() {
    List<SingleChildWidget> list = [];
    list.addAll(generateObserverProvider());
    list.addAll(generateViewModelProvider());
    return list;
  }

  List<SingleChildWidget> generateObserverProvider() {
    return [
      Provider<ForceLogoutObserver>(
        create: (_) => ForceLogoutObserver(),
      ),
      Provider<ActionBackAndroidObserver>(
          create: (_) => ActionBackAndroidObserver()),
    ];
  }

  List<SingleChildWidget> generateViewModelProvider() {
    return [
      Provider<AuthProvider>(create: (_) => AuthProvider()),
    ];
  }
}
