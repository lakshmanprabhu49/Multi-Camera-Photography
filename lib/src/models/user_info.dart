import 'dart:convert';

// Temporary code, need to remove and add actual ones
UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    required this.userId,
    required this.username,
  });

  String userId;
  String username;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
      };
}
