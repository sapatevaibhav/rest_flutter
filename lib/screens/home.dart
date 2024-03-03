import "dart:convert";
import "dart:developer";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "package:rest_flutter/model/user.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "REST Flutter",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user.email;
          final color = user.gender == "male"
              ? const Color.fromARGB(172, 251, 188, 0)
              : const Color.fromARGB(135, 244, 183, 1);
          final name = user.name;
          // final fullName =user.name;
          // name["title"] + ". " + name["first"] + " " + name["last"];
          // final imageUrl = user["picture"]["thumbnail"];
          return ListTile(
            splashColor: Colors.grey,
            focusColor: Colors.grey,
            tileColor: color,
            leading: CircleAvatar(
              // backgroundImage: NetworkImage(
              //   imageUrl,
              // ),
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            title: Text(
              name.first,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              email,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Text(
          "+",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  void fetchUsers() async {
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
      return User(
        gender: e['gender'],
        // name: e["title"] + ". " + e["first"] + " " + e["last"],
        email: e['email'],
        phone: e['phone'],
        nat: e['nat'],
        name: name,
      );
    }).toList();

    setState(() {
      users = transformed;
    });
    log("Got users");
  }
}
