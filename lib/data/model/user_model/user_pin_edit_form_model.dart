class UserPinEditFormModel {
  final String? previousPin;
  final String? newPin;

  const UserPinEditFormModel({
    this.previousPin,
    this.newPin,
  });

  Map<String, dynamic> toJson() {
    return {
      'previous_pin': previousPin,
      "new_pin": newPin,
    };
  }
}

/**
 "previous_pin": 123456,
    "new_pin": 654321
 */

