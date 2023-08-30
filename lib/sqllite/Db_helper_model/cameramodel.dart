import '../Db_helper/camera.dart';

class Cameramodel{
  int ?ID;
  int ?farmerID;
  int ?FieldOfficerID;
  int ?FieldManagerID;
  String ?imagenv;
  double ?Latitude;
  double ?Longitude;
Cameramodel({this.ID,this.farmerID,this.FieldOfficerID,this.FieldManagerID,this.imagenv,this.Latitude,this.Longitude});
  Cameramodel.fromMap(Map<String, dynamic> map) {
    ID = map['ID'];
    farmerID = map['farmerID'];
    FieldOfficerID = map['FieldOfficerID'];
    FieldManagerID= map['FieldManagerID'];
    imagenv = map['imagenv'];
    Latitude = map['Latitude'];
    Longitude=map['Longitude'];
  }
  Map<String, dynamic> toMap() {
    return {
    Camera_sqllite_database.columnid :ID,
      Camera_sqllite_database.columnfarmerID:farmerID,
    Camera_sqllite_database.columnFieldOfficerID:FieldOfficerID,
    Camera_sqllite_database.columnFieldmanagerID:FieldManagerID,
    Camera_sqllite_database.columLatitude:Latitude,
      Camera_sqllite_database.columLongtitude:Longitude,
      Camera_sqllite_database.columnimagenv :imagenv
    };
  }

}