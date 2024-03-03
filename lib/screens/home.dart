import "package:flutter/material.dart";
import "package:rest_flutter/model/user.dart";
import "package:rest_flutter/services/user_api.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

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
          // final email = user.email;
          final color = user.gender == "male"
              ? const Color.fromARGB(172, 251, 188, 0)
              : const Color.fromARGB(135, 244, 183, 1);
          final name = user.fullName;
          final dob = user.userDob.age;
          final address =
              "${user.location.street}, ${user.location.city}, ${user.location.state}, ${user.location.country}, ${user.location.pin}";
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
              "$name ($dob)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              address,
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      //   child: const Text(
      //     "+",
      //     style: TextStyle(
      //       fontSize: 30,
      //     ),
      //   ),
      // ),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
