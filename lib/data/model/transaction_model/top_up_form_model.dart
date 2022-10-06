class TopUpFormModel {
  final String? amount;
  final String? pin;
  final String? paymentMethodCode;

  const TopUpFormModel({
    this.amount,
    this.pin,
    this.paymentMethodCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'pin': pin,
      'payment_method_code': paymentMethodCode,
    };
  }
}

/**
 {
    "amount": 100000,
    "pin": 123456,
    "payment_method_code": "bni_va"
}
 */