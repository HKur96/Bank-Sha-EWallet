class PaymentMethodModel {
  final int? id;
  final String? name;
  final String? code;
  final String? thumbnail;
  final String? status;

  const PaymentMethodModel({
    this.id,
    this.name,
    this.code,
    this.thumbnail,
    this.status,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      thumbnail: json['thumbnail'],
      status: json['status'],
    );
  }
}

/**
 "id": 2,
        "name": "Bank BNI",
        "code": "bni_va",
        "thumbnail": "http://localhost:8000/storage/49OcySnXLE.jpg",
        "status": "active",
        "created_at": "2021-09-04 05:09:57",
        "updated_at": "2021-09-04 05:09:57"
 */