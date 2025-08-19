class LoginRepo {
  LoginRepo._internal();

  static final LoginRepo _loginRepo = LoginRepo._internal();

  factory LoginRepo() => _loginRepo;
}
