// class LoginResponse {
//     int responseStatus;
//     String responseMessage;
//     ResponseData responseData;

//     LoginResponse({
//         required this.responseStatus,
//         required this.responseMessage,
//         required this.responseData,
//     });

// }

// class ResponseData {
//     DateTime serverDateTime;
//     DateTime serverDate;
//     String serverTime;
//     String token;
//     String refreshToken;
//     String username;
//     String password;

//     ResponseData({
//         required this.serverDateTime,
//         required this.serverDate,
//         required this.serverTime,
//         required this.token,
//         required this.refreshToken,
//         required this.username,
//         required this.password,
//     });

// }


import 'dart:convert';

class LoginResponse {
  final int? responseStatus;
  final String? responseMessage;
  final ResponseData? responseData;

  LoginResponse({this.responseStatus, this.responseMessage, this.responseData});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      responseStatus: json['responseStatus'],
      responseMessage: json['responseMessage'],
      responseData: json['responseData'] != null
          ? ResponseData.fromJson(json['responseData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseStatus': responseStatus,
      'responseMessage': responseMessage,
      'responseData': responseData?.toJson(),
    };
  }
}

class ResponseData {
  final String? serverDateTime;
  final String? serverDate;
  final String? serverTime;
  final String? token;
  final String? refreshToken;
  final String? username;
  final String? password;
  final String? usercode;

  ResponseData({
    this.serverDateTime,
    this.serverDate,
    this.serverTime,
    this.token,
    this.refreshToken,
    this.username,
    this.password,
    this.usercode,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      serverDateTime: json['ServerDateTime'],
      serverDate: json['ServerDate'],
      serverTime: json['ServerTime'],
      token: json['Token'],
      refreshToken: json['RefreshToken'],
      username: json['username'],
      password: json['password'],
      usercode: json['usercode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ServerDateTime': serverDateTime,
      'ServerDate': serverDate,
      'ServerTime': serverTime,
      'Token': token,
      'RefreshToken': refreshToken,
      'username': username,
      'password': password,
      'usercode': usercode,
    };
  }
}
