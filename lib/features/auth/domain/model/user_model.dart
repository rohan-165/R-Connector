import 'dart:convert';

//  {
//         "groupid": "10",
//         "username": "support1@vctsdri.gov.np",
//         "userid": "710247",
//         "login_status": 1,
//         "token": "21ybvaSrfXrh8VPzDoLFAKlTSUV0i2L6WOs5r7xpXBJeAgPRxvIrbDGbGUi0"
//     }

class UserModel {
  final String groupId;
  final String userId;
  final String username;
  final int loginStatus;
  final String token;

  UserModel({
    required this.groupId,
    required this.userId,
    required this.username,
    required this.loginStatus,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      groupId: map['groupid'] ?? '',
      userId: map['userid'] ?? '',
      username: map['username'] ?? '',
      loginStatus: map['login_status'] ?? 0,
      token: map['token'] ?? '',
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'groupid': groupId,
      'userid': userId,
      'username': username,
      'login_status': loginStatus,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
}
