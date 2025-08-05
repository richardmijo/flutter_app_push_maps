class UserModel {
  final int? id;
  final String name;
  final String email;

  UserModel({this.id, required this.name, required this.email});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}
