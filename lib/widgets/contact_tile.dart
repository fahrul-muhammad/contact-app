import 'package:flutter/material.dart';
import 'package:testing_app/screens/detail_contact.dart';

var defaltImage =
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2360&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

class ContactTile extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String id;

  const ContactTile({
    super.key,
    required this.name,
    required this.email,
    this.image = '',
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, DetailContact.routeName, arguments: {
          'id': id,
          'name': name,
          'image': image,
          'email': email,
        });
      },
      leading: Hero(
        tag: 'avatar-$id',
        child: CircleAvatar(
          backgroundImage: NetworkImage(image.isNotEmpty ? image : defaltImage),
        ),
      ),
      title: Text(name),
      subtitle: Text(email),
      contentPadding: const EdgeInsets.all(0),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
