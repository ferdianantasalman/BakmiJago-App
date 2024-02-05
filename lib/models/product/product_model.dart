class ProductModel {
  int? id;
  String? image;
  String? code;
  String? name;
  int? price;
  int? qty;
  int? authorId;
  String? category;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.image,
    this.code,
    this.name,
    this.price,
    this.qty,
    this.authorId,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    code = json["code"];
    name = json["name"];
    price = json["price"] != null ? int.parse(json["price"].toString()) : null;
    qty = json["qty"] != null ? int.parse(json["qty"].toString()) : null;
    authorId = json["author_id"] != null
        ? int.parse(json["author_id"].toString())
        : null;

    category = json["category"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['code'] = code;
    data['name'] = name;
    data['price'] = price;
    data['qty'] = qty;
    data['author_id'] = authorId;
    data['category'] = category;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
