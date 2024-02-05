class IncomeModel {
  String? status;
  String? message;
  int? income;

  IncomeModel({
    this.status,
    this.message,
    this.income,
  });

  IncomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    income =
        json["income"] != null ? int.parse(json["income"].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['income'] = income;
    return data;
  }
}
