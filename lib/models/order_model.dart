import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/models/product/product_model.dart';

class OrderModel {
  int? id;
  int? invoiceId;
  int? productId;
  int? qty;
  int? price;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;
  InvoiceModel? invoice;

  OrderModel({
    this.id,
    this.invoiceId,
    this.productId,
    this.qty,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.invoice,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'] != null
        ? int.parse(json['invoice_id'].toString())
        : null;
    productId = json['product_id'] != null
        ? int.parse(json['product_id'].toString())
        : null;
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    invoice =
        json['invoice'] != null ? InvoiceModel.fromJson(json['invoice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_id'] = invoiceId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product?.toJson();
    }
    if (invoice != null) {
      data['invoice'] = invoice?.toJson();
    }
    return data;
  }
}
