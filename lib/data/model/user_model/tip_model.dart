class TipModel {
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnail;

  const TipModel({
    this.id,
    this.title,
    this.url,
    this.thumbnail,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnail: json['thumbnail'],
    );
  }
}


/**
  {
            "id": 1,
            "title": "Cara cepat cuan dari internet",
            "url": "https://fontawesome.com/v5.15/icons/newspaper?style=solid",
            "thumbnail": "http://localhost:8000/storage/szs65Oy06r.jpg"
        }
 */