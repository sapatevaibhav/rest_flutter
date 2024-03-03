class User {
  final String gender, email, phone, nat;
  final UserName name;
  User({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.nat,
  });
}

class UserName {
  final String title, first, last;

  UserName({
    required this.title,
    required this.first,
    required this.last,
  });
}
