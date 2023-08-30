import '../Db_helper/vilagesdbhelper.dart';

class Village {
  int ?id;
 String ?villageName;
 int? villageID;
 int ?TalukaID;
  String ?TalukaName;
  String ?DistrictName;

 Village(this.id,this.villageName,this.DistrictName,this.TalukaName,this.TalukaID,this.villageID);

 Village.fromMap(Map<String, dynamic> map) {
   id = map['id'];
   villageID = map['villageID'];
   villageName = map['villageName'];
   TalukaID= map['TalukaID'];
    TalukaName = map['TalukaName'];
    DistrictName = map['DistrictName'];
  }

  Map<String, dynamic> toMap() {
    return {
    DatabaseHelper.columnId : id,
    DatabaseHelper.columnvillageid : villageID,
    DatabaseHelper.columnname  : villageName,
    DatabaseHelper.columnTalukaID : TalukaID,
    DatabaseHelper.columnTalukaName  : TalukaName,
    DatabaseHelper.columnDistrictName  : DistrictName,
    };
  }
}