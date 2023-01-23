import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_user_api/view_models/users_view_model.dart';

import '../../get_it.dart';
import 'components/user_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final vm = getIt<UserViewModel>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('List of Users'),
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

                return Scrollbar(
                  key: const Key('Scrollbar'),
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        users.length,
                        (index) {
                          return UserWidget(
                            user: users[index],
                          );
                        },
                      ),
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

  void _loadMoreUsers() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      vm.fetchUsers();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreUsers);
    super.dispose();
  }
}
