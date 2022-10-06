class DataPlanModel {
  final int? id;
  final String? name;
  final int? price;
  final int? operatorCardId;

  const DataPlanModel({
    this.id,
    this.name,
    this.price,
    this.operatorCardId,
  });

  factory DataPlanModel.fromJson(Map<String, dynamic> json) {
    return DataPlanModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      operatorCardId: json['operator_card_id'],
    );
  }
}
/**
 * {
                        "id": 1,
                        "name": "10 GB",
                        "price": 100000,
                        "operator_card_id": 1,
                        "created_at": "2021-09-21T01:35:23.000000Z",
                        "updated_at": "2021-09-21T01:35:23.000000Z"
                    },
 */