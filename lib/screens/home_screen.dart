import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:testing_app/models/user/user.dart';
import 'package:testing_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const routeName = "home-screen";
  String input = "";
  List<Users> usersList = [];
  List<Users> displayedUsersList = [];
  bool noUsersFound = false;

  @override
  void initState() {
    super.initState();
    getDataFromHive();
  }

  void getDataFromHive() async {
    final usersBox = await Hive.openBox<Users>('usersBox');
    if (usersBox.isNotEmpty) {
      List<Users> users = usersBox.values.toList();
      setState(() {
        usersList = users;
        displayedUsersList = List.from(usersList);
      });
    } else {
      await Users.getDataUsers();
      List<Users> users = usersBox.values.toList();
      setState(() {
        usersList = users;
        displayedUsersList = List.from(usersList);
      });
    }
  }

  void filterUsers(String keyword) {
    List<Users> filteredUsers = usersList.where((user) {
      String fullName = user.name!.toLowerCase();
      String searchLower = keyword.toLowerCase();
      return fullName.contains(searchLower);
    }).toList();
    setState(() {
      displayedUsersList = filteredUsers;
      noUsersFound = displayedUsersList.isEmpty;
    });
  }

  void resetUsersList() {
    setState(() {
      displayedUsersList = List.from(usersList);
      noUsersFound = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TextField(
                  autocorrect: false,
                  cursorColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      input = value;
                    });
                    if (value.isEmpty) {
                      resetUsersList();
                    } else {
                      filterUsers(value);
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Cari...",
                    alignLabelWithHint: false,
                    focusColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                ),
                if (noUsersFound)
                  const Text(
                    'User tidak ditemukan',
                    style: TextStyle(color: Colors.red),
                  ),
                if (!noUsersFound)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayedUsersList.length,
                    itemBuilder: (context, index) {
                      return ContactTile(
                        id: displayedUsersList[index].id.toString(),
                        name: displayedUsersList[index].name ?? 'User',
                        email: displayedUsersList[index].email ?? 'Unknown',
                        image: displayedUsersList[index].avatar.toString(),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
