import 'package:flutter/material.dart';
import 'package:random_user_api/pages/user_details/user_details_page.dart';
import 'package:random_user_api/shared/utils/nav.dart';

import '../../../models/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    required this.user,
    Key? key,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        push(context, UserDetailsPage(user: user));
      },
      title: Text(
        '${user.firstName} ${user.lastName}',
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        user.email,
        style: const TextStyle(color: Colors.white70),
      ),
      leading: user.thumbnail.isEmpty
          ? null
          : Hero(
              tag: user.email,
              child: ClipOval(
                child: Image.network(user.thumbnail),
              ),
            ),
    );
  }
}
