import "dart:convert";
import "dart:developer";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("REST Flutter"),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user['email'];
          final name = user['name'];
          final fullName =
              name["title"] + ". " + name["first"] + " " + name["last"];
          final imageUrl = user["picture"]["thumbnail"];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              // child: Text(
              //   "${index + 1}",
              //   style: const TextStyle(
              //     fontSize: 20,
              //   ),
              // ),
            ),
            title: Text(
              fullName,
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

    setState(() {
      users = json['results'];
    });
    log("Got users");
  }
}
