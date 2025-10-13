import 'dart:convert';

class SuccessModel {
  String? token;
  UserModel? userModel;
  String? appVersions;

  SuccessModel({this.token, this.userModel, this.appVersions});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userModel = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    appVersions = json['app_versions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (userModel != null) {
      data['user'] = userModel!.toJson();
    }
    data['app_versions'] = appVersions;
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? isSuper;
  int? userType;
  List<int>? company;
  String? createdAt;
  String? updatedAt;
  String? username;
  String? phone;
  String? deletedAt;
  String? office;
  String? locationType;
  int? status;
  String? firstOtp;
  String? otp;
  List<int>? location;
  List<String>? branches;

  bool? isLocalDataBase;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isSuper,
    this.userType,
    this.company,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.phone,
    this.deletedAt,
    this.office,
    this.locationType,
    this.status,
    this.firstOtp,
    this.otp,
    this.location,
    this.branches,

    this.isLocalDataBase = false,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isSuper = json['is_super'];
    userType = json['user_type'];
    if (json['company'] is String) {
      company = jsonDecode(json['company']) is List
          ? List<int>.from(jsonDecode(json['company']))
          : <int>[];
    } else if (json['company'] is List) {
      company = json['company'] != null
          ? List<int>.from(json['company'])
          : <int>[];
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    username = json['username'];
    phone = json['phone'];
    deletedAt = json['deleted_at'];
    office = json['office'];
    locationType = json['location_type'];
    status = json['status'];
    firstOtp = json['first_otp'];
    otp = json['otp'];
    // location = json['location'] != null
    //     ? List<int>.from(json['location'])
    //     : <int>[];
    if (json['branches'] is String) {
      branches = jsonDecode(json['branches']) is List
          ? List<String>.from(jsonDecode(json['branches']))
          : <String>[];
    } else if (json['branches'] is List) {
      branches = json['branches'] != null
          ? List<String>.from(json['branches'])
          : <String>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_super'] = isSuper;
    data['user_type'] = userType;
    data['company'] = company?.map((e) => e).toList();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['username'] = username;
    data['phone'] = phone;
    data['deleted_at'] = deletedAt;
    data['office'] = office;
    data['location_type'] = locationType;
    data['status'] = status;
    data['first_otp'] = firstOtp;
    data['otp'] = otp;
    // data['location'] = location?.map((e) => e).toList();
    data['branches'] = branches?.map((e) => e).toList();
    return data;
  }

  Map<String, dynamic> toDatabaseJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_super'] = isSuper;
    data['user_type'] = userType;
    data['company'] = jsonEncode(company?.map((e) => e).toList());
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['username'] = username;
    data['phone'] = phone;
    data['deleted_at'] = deletedAt;
    data['office'] = office;
    data['location_type'] = locationType;
    data['status'] = status;
    data['first_otp'] = firstOtp;
    data['otp'] = otp;
    // data['location'] = location?.map((e) => e).toList();
    data['branches'] = jsonEncode(branches?.map((e) => e).toList());
    return data;
  }
}
