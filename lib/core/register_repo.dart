class RegisterRepo {
  RegisterRepo._internal();
  static final RegisterRepo _registerRepo = RegisterRepo._internal();

  factory RegisterRepo() => _registerRepo;
}
