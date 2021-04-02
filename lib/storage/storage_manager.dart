
import 'auth/local/auth_local.dart';
import 'auth/local/auth_local_imp.dart';
import 'auth/remote/auth_remote.dart';
import 'auth/remote/auth_remote_imp.dart';
// các storage sẽ được khởi tạo thông qua storage manager
class StorageManager {

  static T getLocalStorage<T>() {
    switch (T) {
      case AuthLocal: return AuthLocalImp() as T;
      default:
        return null;
    }
  }

  static T getRemoteStorage<T>() {
    switch(T) {
      case AuthRemote: return AuthRemoteImp() as T;
      default:
        return null;
    }
  }
}