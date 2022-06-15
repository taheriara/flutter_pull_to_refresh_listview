import 'dart:convert';
import 'package:flutter_pull_to_refresh_listview/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RefreshListview extends StatefulWidget {
  const RefreshListview({Key? key}) : super(key: key);

  @override
  State<RefreshListview> createState() => _RefreshListviewState();
}

class _RefreshListviewState extends State<RefreshListview> {
  List<User> users = [];

  Future refresh() async {
    setState(() => users.clear());

    // load from api
    const url = "https://jsonplaceholder.typicode.com/albums";
    final response = await http.get(Uri.parse(url));
     if (response.statusCode == 200) {
      final List newUsers = jsonDecode(response.body);
      setState(() {
        users = newUsers.map<User>(User.fromJson).toList();
      });
    } else {
      setState(() {
        users = [User(userId: 0, id: 0, title: 'error ${response.statusCode}')];
      });
    }

    //---------------- Or load json from asset -------------------
    // //just for delay to show CircularProgressIndicator
    // await Future.delayed(const Duration(milliseconds: 500)); 
    //
    // final assetBundle = DefaultAssetBundle.of(context);
    // final response = await assetBundle.loadString('assets/users.json');
    // final List newUsers = jsonDecode(response);
    // setState(() {
    //  users = newUsers.map<User>(User.fromJson).toList();
    // });

  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pull To Refresh'),
        actions: [
          IconButton(onPressed: refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.id.toString()),
                    subtitle: Text(user.title),
                  );
                },
              ),
            ),
    );
  }
}
