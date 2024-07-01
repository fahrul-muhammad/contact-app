import 'dart:math';

import 'package:flutter/material.dart';

class DetailContact extends StatelessWidget {
  static const routeName = 'detail-contact';

  const DetailContact({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Detail"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Image.network(
                    'https://picsum.photos/id/${1 + Random().nextInt(100)}/200/200',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 160,
                  bottom: 50,
                  child: Center(
                    child: Hero(
                      tag: 'avatar-${data?['id']}',
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        backgroundImage: NetworkImage(data?['image'] ?? ''),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              data?['name'] ?? 'Name not found',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              data?['email'] ?? 'Email not found',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
