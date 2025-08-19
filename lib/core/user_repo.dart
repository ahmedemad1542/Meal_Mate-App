class UserRepo {
  UserRepo._internal();
  static final UserRepo _userRepo = UserRepo._internal();
  factory UserRepo() => _userRepo;
}
