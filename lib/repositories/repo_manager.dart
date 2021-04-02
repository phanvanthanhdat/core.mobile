
import 'auth/auth_imp.dart';
import 'auth/auth_repo.dart';
class RepoManager {

  //[START]Singleton
  static final RepoManager _instance =  RepoManager._internal();

  factory RepoManager() {
    return _instance;
  }
  RepoManager._internal();
  //[END]Singleton

  final List<dynamic> _objects = [];

  dynamic _getInstanceOfType<T>() {
    for (var element in _objects) {
      if (element is T) {
        return element;
      }
    }
    return null;
  }

  T get<T>() {
    var returnValue = _getInstanceOfType<T>();
    if (returnValue != null ) {
      return returnValue;
    }

    switch(T) {
      case AuthRepo:
        returnValue = AuthImp() as T;
        break;
      default:
        return null;
    }
    _objects.add(returnValue);//add object into list to return the same object
    return returnValue;
  }
}