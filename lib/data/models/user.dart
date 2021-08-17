import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.photoUrl,
    this.phoneNumber,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String email;
  @HiveField(4)
  String photoUrl;
  @HiveField(5)
  String phoneNumber;

  User copyWith({
    String id,
    String firstName,
    String lastName,
    String email,
    String photoUrl,
    String phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory User.fromFirestore(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        photoUrl: json["photo_url"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toFirestore() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "photo_url": photoUrl,
        "phone_number": phoneNumber,
      };
}
