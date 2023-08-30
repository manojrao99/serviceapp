import '../Db_helper/clintlistdbhelper.dart';

class Clintlistsqlformate{
  int ?id;
  int?CLintId;
  String? ClintName;
  Clintlistsqlformate({this.id,this.CLintId,this.ClintName});
  Clintlistsqlformate.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    CLintId= map['CLintId'];
    ClintName = map['ClintName'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseclintHelper.columnId: id,
      DatabaseclintHelper.columnClintID: CLintId,
      DatabaseclintHelper.columnClintName: ClintName,

    };
  }
}