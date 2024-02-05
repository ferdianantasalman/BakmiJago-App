class OutcomeModel {
  String? status;
  String? message;
  int? outcome;

  OutcomeModel({
    this.status,
    this.message,
    this.outcome,
  });

  OutcomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    outcome =
        json["outcome"] != null ? int.parse(json["outcome"].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['outcome'] = outcome;
    return data;
  }
}
