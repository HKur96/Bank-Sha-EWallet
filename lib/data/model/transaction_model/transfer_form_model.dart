class TransferFormModel {
  final String? amount;
  final String? pin;
  final String? sendTo;

  const TransferFormModel({
    this.amount,
    this.pin,
    this.sendTo,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'pin': pin,
      'send_to': sendTo,
    };
  }

  TransferFormModel copyWith({String? amount, String? pin, String? sendTo}) {
    return TransferFormModel(
      amount: amount ?? this.amount,
      pin: pin ?? this.pin,
      sendTo: sendTo ?? this.sendTo,
    );
  }
}

/**
 {
    "amount": 5000,
    "pin": 123456,
    "send_to": "widada15@buildwithangga.com"
}
 */