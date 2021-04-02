
//Giao tiếp giữu page và presenter
abstract class SignInView {
  Future<bool> showLoading();
  Future<bool> hideLoading();
  Future<void> showLoginFail();
}
// giao tiếp giữ các user case với nhau thay vì dùng callback dùng abstract sẽ trực quan hơn
abstract class SignInUseCaseOutput implements SignInUseCaseValidateOutput{

}

abstract class SignInUseCaseValidateOutput {
    void userNameWithError(String err, bool isLogin);
    void passwordWithError(String err, bool isLogin);
}
