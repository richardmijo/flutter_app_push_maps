class GeoObject {
  final int? id;
  final int? userId;
  final String name;
  final String type; // 'point', 'route', o 'polygon'
  final List<List<double>> coordinates;

  GeoObject({
    this.id,
    this.userId,
    required this.name,
    required this.type,
    required this.coordinates,
  });

  factory GeoObject.fromJson(Map<String, dynamic> json) {
  return GeoObject(
    id: json['id'],
    userId: json['user_id'],
    name: json['name'],
    type: json['type'],
    coordinates: (json['coordinates'] as List)
        .map<List<double>>(
          (coord) => (coord as List<dynamic>)
              .map<double>((e) => e.toDouble())
              .toList(),
        )
        .toList(),
  );
}

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      'name': name,
      'type': type,
      'coordinates': coordinates,
    };
  }
}
