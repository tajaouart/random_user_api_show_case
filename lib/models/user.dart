class User {
  final String firstName;
  final String lastName;
  final String email;
  final String largeImage;
  final String mediumImage;
  final String thumbnail;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.largeImage,
    required this.mediumImage,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'large_image': largeImage,
      'medium_image': mediumImage,
      'thumbnail': thumbnail,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      largeImage: json['picture']['large'] ?? '',
      mediumImage: json['picture']['medium'] ?? '',
      thumbnail: json['picture']['thumbnail'] ?? '',
    );
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      largeImage: json['large_image'],
      mediumImage: json['medium_image'],
      thumbnail: json['thumbnail'],
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
