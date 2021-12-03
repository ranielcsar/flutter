import 'package:fetch_data/fetchs/fetch_users.dart';
import 'package:fetch_data/layout/user_card.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UserState extends State<MyApp> {
  late Future<List<dynamic>> users;
  int page = 1;
  bool isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    users = fetchUsers(page);
  }

  void fetchMoreUsers() async {
    isFetchingMore = true;
    page = 2;
    var newUsers = await fetchUsers(page);
    users = (List.from(newUsers)..addAll(await users)) as Future<List>;
    isFetchingMore = false;
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
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              int length = snapshot.data!.length - 1;

                              if (length == index) {
                                return ElevatedButton(
                                  onPressed: fetchMoreUsers,
                                  child: isFetchingMore
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text('Carregar mais...'),
                                );
                              }

                              return UserCard(
                                email: snapshot.data![index]['email'],
                                location: _location(snapshot.data![index]),
                                name: _name(snapshot.data![index]),
                                profileImage: snapshot.data![index]['picture']
                                    ['large'],
                              );
                            },
                          ),
                        ),
                      ],
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
