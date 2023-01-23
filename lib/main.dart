import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_user_api/view_models/users_view_model.dart';

import 'get_it.dart';
import 'pages/home/home.dart';
import 'shared/utils/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const _AppProviders(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random User API Demo',
      theme: myTheme,
      home: const MyHomePage(),
    );
  }
}

class _AppProviders extends StatelessWidget {
  const _AppProviders({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<UserViewModel>(),
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
