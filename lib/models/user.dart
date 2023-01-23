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
