class DonutItem {
    DonutItem({
        required this.id,
        required this.type,
        required this.name,
        required this.ppu,
        required this.batters,
        required this.topping,
    });

    String id;
    String type;
    String name;
    double ppu;
    Batters batters;
    List<Topping> topping;

    factory DonutItem.fromJson(Map<String, dynamic> json) => DonutItem(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        ppu: json["ppu"]?.toDouble(),
        batters: Batters.fromJson(json["batters"]),
        topping: List<Topping>.from(json["topping"].map((x) => Topping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "ppu": ppu,
        "batters": batters.toJson(),
        "topping": List<dynamic>.from(topping.map((x) => x.toJson())),
    };
}

class Batters {
    Batters({
        required this.batter,
    });

    List<Topping> batter;

    factory Batters.fromJson(Map<String, dynamic> json) => Batters(
        batter: List<Topping>.from(json["batter"].map((x) => Topping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "batter": List<dynamic>.from(batter.map((x) => x.toJson())),
    };
}

class Topping {
    Topping({
        required this.id,
        required this.type,
    });

    String id;
    String type;

    factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json["id"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
    };
}
