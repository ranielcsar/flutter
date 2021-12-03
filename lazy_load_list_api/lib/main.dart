import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

Future<dynamic> _getUsers(int page) async {
  const int _limitPerPage = 20;
  String newUsers =
      "https://randomuser.me/api/?page=$page&results=$_limitPerPage&nat=br";

  final dio = Dio();

  dynamic response = await dio.get(newUsers);
  List users = response.data['results'];

  return users;
}

class HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  int page = 0;

  bool isLoading = false;

  List users = [];

  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    List temporaryList = [];
    List newUsers = await _getUsers(page);
    page += 1;

    for (int i = 0; i < newUsers.length; i++) {
      temporaryList.add(newUsers[i]);
    }

    setState(() {
      isLoading = false;
      users.addAll(temporaryList);
    });
  }

  @override
  void initState() {
    _getMoreData();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: users.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            title: Text(
              (users[index]['name']['first']),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {},
          );
        }
      },
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paginação infinita"),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
