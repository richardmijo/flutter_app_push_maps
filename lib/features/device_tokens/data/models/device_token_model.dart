class DeviceTokenModel {
  final int? id;
  final String token;
  final int? userId;

  DeviceTokenModel({
    this.id,
    required this.token,
    this.userId,
  });

  factory DeviceTokenModel.fromJson(Map<String, dynamic> json) {
    return DeviceTokenModel(
      id: json['id'],
      token: json['token'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      if (userId != null) 'user_id': userId,
    };
  }
}
