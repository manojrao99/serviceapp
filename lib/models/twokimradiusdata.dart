class Twokimradiusdata {
  int? polygonID;
  int? polygonSortOrder;
  int? villageID;
  double? latitude;
  double? longitude;

  Twokimradiusdata(
      {this.polygonID,
        this.polygonSortOrder,
        this.villageID,
        this.latitude,
        this.longitude});

  Twokimradiusdata.fromJson(Map<String, dynamic> json) {
    polygonID = json['PolygonID'];
    polygonSortOrder = json['PolygonSortOrder'];
    villageID = json['VillageID'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PolygonID'] = this.polygonID;
    data['PolygonSortOrder'] = this.polygonSortOrder;
    data['VillageID'] = this.villageID;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}