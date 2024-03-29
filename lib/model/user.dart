import 'package:rest_flutter/model/user_address.dart';
import 'package:rest_flutter/model/user_dob.dart';
import 'package:rest_flutter/model/user_name.dart';

class User {
  final String gender, email, phone, nat;
  final UserName name;
  final UserDob userDob;
  final UserLocation location;
  User({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.nat,
    required this.userDob,
    required this.location,
  });
  String get fullName {
    return '${name.title}. ${name.first} ${name.last}';
  }
}
