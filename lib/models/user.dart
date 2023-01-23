class User {
  String? firstName;
  String? lastName;
  String? email;

  User({this.firstName, this.lastName, this.email});

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
    );
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  static List<User> fromJsonList(List<dynamic> jsonArray) {
    return List.generate(
      jsonArray.length,
      (index) {
        return User.fromMap(jsonArray[index]);
      },
    );
  }

  @override
  String toString() {
    return 'User{firstName: $firstName, lastName: $lastName, email: $email}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ email.hashCode;
}
