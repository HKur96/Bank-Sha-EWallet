class DataPlanFormModel {
  final int? dataPlanId;
  final String? phoneNumber;
  final String? pin;

  const DataPlanFormModel({
    this.dataPlanId,
    this.phoneNumber,
    this.pin,
  });

  Map<String, dynamic> toJson() {
    return {
      'data_plan_id': dataPlanId.toString(),
      'phone_number': phoneNumber,
      'pin': pin,
    };
  }
}

/**
 {
    "data_plan_id": 1,
    "phone_number": "086712312323",
    "pin": 123456
}
 */