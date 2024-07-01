// users.dart

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'user.g.dart';

@HiveType(typeId: 0)
class Users {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? avatar;

  Users({this.id, this.name, this.email, this.avatar});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'].toString(),
      name: json['first_name'] + " " + json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  static Future<void> getDataUsers() async {
    final url = Uri.parse('https://reqres.in/api/users?page=1');
    final secondUrl = Uri.parse('https://reqres.in/api/users?page=2');
    try {
      final response = await http.get(url);
      final secondResponse = await http.get(secondUrl);
      final List data = json.decode(response.body)['data'];
      final List secondData = json.decode(secondResponse.body)['data'];
      final usersBox = await Hive.openBox<Users>('usersBox');
      for (var userData in data) {
        Users user = Users.fromJson(userData);
        usersBox.add(user);
      }
      for (var userData in secondData) {
        Users user = Users.fromJson(userData);
        usersBox.add(user);
      }
    } catch (e) {
      rethrow;
    }
  }
}
