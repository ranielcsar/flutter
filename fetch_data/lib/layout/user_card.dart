import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserCard extends StatelessWidget {
  UserCard(
      {Key? key,
      required this.name,
      required this.location,
      required this.profileImage,
      required this.email})
      : super(key: key);

  final String name;
  final String location;
  final String profileImage;
  final String email;

  late NetworkImage cardImage = NetworkImage(profileImage);

  final supportingText = 'Texto :D';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 1)
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: cardImage,
              radius: 20,
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            trailing: const Icon(Icons.star_outline),
          )
        ],
      ),
    );
  }
}
