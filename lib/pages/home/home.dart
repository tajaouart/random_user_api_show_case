import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_user_api/view_models/users_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Consumer<UserViewModel>(
        builder: (BuildContext context, value, Widget? child) {
          final users = value.users;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(users.length, (index) {
                return Text(users[index].firstName ?? '');
              }),
            ),
          );
        },
      ),
    );
  }
}
