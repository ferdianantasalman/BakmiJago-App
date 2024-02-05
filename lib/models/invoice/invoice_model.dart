class InvoiceModel {
  int? id;
  String? invoice;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;

  InvoiceModel(
      {this.id, this.invoice, this.totalPrice, this.createdAt, this.updatedAt});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice = json['invoice'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice'] = this.invoice;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
