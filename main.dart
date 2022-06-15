import 'package:flutter_pull_to_refresh_listview/refresh_listview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull to refresh listview',
      ),
      home: const RefreshListview(),
    );
  }
}
