class Taluka {
  final String talukaName;
  final int talukaID;
  final int districtID;

  Taluka({
    required this.talukaName,
    required this.talukaID,
    required this.districtID,
  });

  factory Taluka.fromJson(Map<String, dynamic> json) {
    return Taluka(
      talukaName: json['TalukaName'],
      talukaID: json['TalukaID'],
      districtID: json['DistricID'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'TalukaName': talukaName,
      'TalukaID': talukaID,
      'DistricID': districtID,
    };
  }
}
