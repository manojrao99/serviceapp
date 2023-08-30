class Village {
  final String villageName;
  final int villageID;
  final int talukaID;

  Village({
    required this.villageName,
    required this.villageID,
    required this.talukaID,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      villageName: json['VillageName'],
      villageID: json['VillageID'],
      talukaID: json['TalukaID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'VillageName': villageName,
      'VillageID': villageID,
      'TalukaID': talukaID,
    };
  }
}
