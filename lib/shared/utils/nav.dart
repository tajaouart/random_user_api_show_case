import 'package:flutter/material.dart';

Future<Object?> push(BuildContext context, Widget page) {
  return Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}
