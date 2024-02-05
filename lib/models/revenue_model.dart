class RevenueModel {
  String? status;
  String? message;
  int? income;
  int? outcome;
  int? revenue;

  RevenueModel({
    this.status,
    this.message,
    this.income,
    this.outcome,
    this.revenue,
  });

  RevenueModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    income =
        json["income"] != null ? int.parse(json["income"].toString()) : null;
    outcome =
        json["outcome"] != null ? int.parse(json["outcome"].toString()) : null;
    revenue =
        json["revenue"] != null ? int.parse(json["revenue"].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['income'] = income;
    data['outcome'] = outcome;
    data['revenue'] = revenue;
    return data;
  }
}
