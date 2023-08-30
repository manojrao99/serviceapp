class District {
  final String districtName;
  final int districtID;

  District({required this.districtName, required this.districtID});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      districtName: json['DisticName'],
      districtID: json['DisticID'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'districtName': districtName,
      'districtID': districtID,
    };
  }
}
