class LoginModel {
  Token? token;
  String? phone;
  bool? status;
  bool? privilage;
  String? message;

  LoginModel({this.token, this.phone, this.status, this.privilage, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    phone = json['phone'];
    status = json['status'];
    privilage = json['privilage'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (token != null) {
      data['token'] = token!.toJson();
    }
    data['phone'] = phone;
    data['status'] = status;
    data['privilage'] = privilage;
    data['message'] = message;
    return data;
  }
}

class Token {
  String? refresh;
  String? access;

  Token({this.refresh, this.access});

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
