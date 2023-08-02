class User {
  String? username;
  String? email;

  User({this.email, this.username});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'];
}
