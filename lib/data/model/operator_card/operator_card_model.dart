import '../../../data/model/operator_card/data_plan_model.dart';

class OperatorCardModel {
  final int? id;
  final String? name;
  final String? status;
  final String? thumbnail;
  final List<DataPlanModel>? dataPlans;

  const OperatorCardModel({
    this.id,
    this.name,
    this.status,
    this.thumbnail,
    this.dataPlans,
  });

  factory OperatorCardModel.fromJson(Map<String, dynamic> json) {
    return OperatorCardModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      thumbnail: json['thumbnail'],
      dataPlans: json['data_plans'] == null
          ? null
          : (json['data_plans'] as List)
              .map((dataPlan) => DataPlanModel.fromJson(dataPlan))
              .toList(),
    );
  }
}
/**
 "id": 1,
            "name": "Telkomsel",
            "status": "active",
            "thumbnail": "http://localhost:8000/telkomsel.png",
            "created_at": null,
            "updated_at": null,
            "data_plans": [
 */