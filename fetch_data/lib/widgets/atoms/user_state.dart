import 'package:fetch_data/fetchs/fetch_users.dart';
import 'package:fetch_data/layout/user_card.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UserState extends State<MyApp> {
  late Future<List<dynamic>> user;

  @override
  void initState() {
    super.initState();
    user = fetchUsers();
  }

  String _name(dynamic user) {
    return '${user['name']['title']} ${user['name']['first']} ${user['name']['last']}';
  }

  String _location(dynamic user) {
    return '${user['location']['city']} / ${user['location']['state']}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data :D'),
          ),
          body: Center(
            child: FutureBuilder<List<dynamic>>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          email: snapshot.data![index]['email'],
                          location: _location(snapshot.data![index]),
                          name: _name(snapshot.data![index]),
                          profileImage: snapshot.data![index]['picture']
                              ['large'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }),
          ),
        ));
  }
}
