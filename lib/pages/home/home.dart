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
      appBar: AppBar(
        title: Text('All Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserViewModel>(
          builder: (_, vm, __) {
            final users = vm.users;

            return vm.state.map(
              initial: (_) => const SizedBox(),
              error: (_) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              loading: (_) {
                return const Center(child: CircularProgressIndicator());
              },
              loaded: (_) {
                if (users.isEmpty) {
                  return const Center(
                    child: Text(
                      'Empty',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      users.length,
                      (index) {
                        return Text(users[index].firstName ?? '');
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
