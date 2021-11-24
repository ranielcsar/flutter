class Picture {
  late String medium;
}

class Name {
  late String title;
  late String first;
  late String last;
}

class Location {
  late String city;
  late String state;
}

class User {
  final Name name;
  final Location location;
  final String email;
  final Picture picture;

  User(
      {required this.name,
      required this.location,
      required this.email,
      required this.picture});

  factory User.fromJson(Map<User, dynamic> json) {
    return User(
      name: json['name']['title' 'first' 'last'],
      location: json['location']['street' 'city'],
      email: json['email'],
      picture: json['picture']['medium'],
    );
  }
}
