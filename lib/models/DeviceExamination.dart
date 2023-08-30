class TelematicModel {
  int id;
  String? deviceID;
  bool? online;
  DateTime? lastOperatingDateTime;
  DateTime? operatingSinceDateTime;
  double?wp;
  double?fc;
  double? l1;
  double? l2;
  double? l3;
  double? l4;
  String? l1Color;
  String? l2Color;
  String? l3Color;
  String? l4Color;
  double? emVolatgeB;
  double? emVolatgeR;
  double? emVolatgeY;
  double? emCurrentB;
  double? emCurrentR;
  double? emCurrentY;
  double? batteryMV;
  DateTime? sensorDataPacketDateTime;
  int? operatingMode;

  TelematicModel(
      {required this.id,
        this.deviceID,
        this.sensorDataPacketDateTime,
        this.online,
        this.lastOperatingDateTime,
        this.operatingSinceDateTime,
        this.l1,
        this.l2,
        this.l3,
        this.l4,
        this.wp,
        this.fc,
        this.l1Color,
        this.l2Color,
        this.l3Color,
        this.l4Color,
        this.batteryMV,
        this.emCurrentB,
        this.emCurrentR,
        this.emCurrentY,
        this.emVolatgeB,
        this.emVolatgeR,
        this.emVolatgeY,
        this.operatingMode});

  factory TelematicModel.fromJson(Map<String, dynamic> json) {
    if ((json['ID'] ?? 0) == 0) {
      return TelematicModel(id: 0, deviceID: json['deviceID']);
    } else {
      return TelematicModel(
        id: (json['ID'] ?? 0),
        deviceID: json['DeviceID'],
        online: json['Online'],
        lastOperatingDateTime: (json['LastOperatingDateTime'] != null)
            ? DateTime.tryParse(json['LastOperatingDateTime'])
            : null,
        operatingSinceDateTime: json['OperatingSinceDateTime'] != null
            ? DateTime.tryParse(json['OperatingSinceDateTime'] ?? '')
            : null,
        l1Color: (json['L1Color'] ?? ''),
        l2Color: (json['L2Color'] ?? ''),
        l3Color: (json['L3Color'] ?? ''),
        l4Color: (json['L4Color'] ?? ''),
        l1: (json['L1'] ?? 0) + 0.0,
        l2: (json['L2'] ?? 0) + 0.0,
        l3: (json['L3'] ?? 0) + 0.0,
        l4: (json['L4'] ?? 0) + 0.0,
        fc:(json['fc'] ??0)+0.0,
        wp: (json['wp'] ??0)+0.0,

        batteryMV: (json['BatteryMV'] ?? 0) + 0.0,
        emCurrentB: (json['EMCurrentB'] ?? 0) + 0.0,
        emCurrentR: (json['EMCurrentR'] ?? 0) + 0.0,
        emCurrentY: (json['EMCurrentY'] ?? 0) + 0.0,
        emVolatgeB: (json['EMVoltageB'] ?? 0) + 0.0,
        emVolatgeR: (json['EMVoltageR'] ?? 0) + 0.0,
        emVolatgeY: (json['EMVoltageY'] ?? 0) + 0.0,
        operatingMode: json['OperatingMode'],
        sensorDataPacketDateTime:
        DateTime.tryParse(json['SensorDataPacketDateTime']),
      );
    }
  }
}
