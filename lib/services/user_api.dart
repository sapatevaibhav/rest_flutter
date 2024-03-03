import 'dart:developer';
import "package:http/http.dart" as http;
import "package:rest_flutter/model/user.dart";
import "package:rest_flutter/model/user_dob.dart";
import "dart:convert";
import "package:rest_flutter/model/user_name.dart";

class UserApi {
  static Future<List<User>> fetchUsers() async {
    log("Fetching Users...");
    const url = 'https://randomuser.me/api/?results=15';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      final dob = UserDob(
        dateTime: DateTime.parse(e['dob']['date']),
        age: e['dob']['age'],
      );
      return User(
        gender: e['gender'],
        // name: e["title"] + ". " + e["first"] + " " + e["last"],
        email: e['email'],
        phone: e['phone'],
        nat: e['nat'],
        name: name,
        userDob: dob,
      );
    }).toList();
    return transformed;
  }
}
