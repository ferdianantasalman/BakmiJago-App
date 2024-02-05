class ReportModel {
  int? id;
  String? name;
  int? price;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  ReportModel(
      {this.id,
      this.name,
      this.price,
      this.keterangan,
      this.createdAt,
      this.updatedAt});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['keterangan'] = this.keterangan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
