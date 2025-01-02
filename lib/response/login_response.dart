class LoginResponse {
    int responseStatus;
    String responseMessage;
    ResponseData responseData;

    LoginResponse({
        required this.responseStatus,
        required this.responseMessage,
        required this.responseData,
    });

}

class ResponseData {
    DateTime serverDateTime;
    DateTime serverDate;
    String serverTime;
    String token;
    String refreshToken;
    String username;
    String password;

    ResponseData({
        required this.serverDateTime,
        required this.serverDate,
        required this.serverTime,
        required this.token,
        required this.refreshToken,
        required this.username,
        required this.password,
    });

}
