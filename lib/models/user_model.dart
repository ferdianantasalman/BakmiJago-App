class UserModel {
  int? id;
  int? roleId;
  String? name;
  String? username;
  String? email;
  int? noTelpon;
  String? alamat;
  String? status;
  String? createdAt;
  String? updatedAt;
  Role? role;

  UserModel(
      {this.id,
      this.roleId,
      this.name,
      this.username,
      this.email,
      this.noTelpon,
      this.alamat,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    roleId = int.parse(json['role_id'].toString());
    name = json['name'];
    username = json['username'];
    email = json['email'];
    noTelpon = int.parse(json['no_telpon'].toString());
    alamat = json['alamat'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['no_telpon'] = noTelpon;
    data['alamat'] = alamat;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.name, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
