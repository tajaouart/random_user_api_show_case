import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({required this.user, Key? key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          '${user.firstName} ${user.lastName}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              Hero(
                tag: user.email,
                child: ClipOval(
                  child: Image.network(user.largeImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  user.email,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
