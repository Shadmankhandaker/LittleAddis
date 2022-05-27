class UpdateproModel2 {
  String? responseCode;
  String? message;
  String? status;

  UpdateproModel2({
    this.responseCode,
    this.message,
    this.status,
  });

  UpdateproModel2.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['response_code'] = responseCode;
    data['message'] = message;
    data['status'] = status;

    return data;
  }
}
