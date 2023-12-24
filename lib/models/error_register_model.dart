class ErrorRegisterModel {
  List<String>? username;
  List<String>? email;

  ErrorRegisterModel({this.username, this.email});

  ErrorRegisterModel.fromJson(Map<String, dynamic> json) {
    username = json['username'].cast<String>();
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
