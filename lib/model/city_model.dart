class City {
  City({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  String name;
  double latitude;
  double longitude;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}
