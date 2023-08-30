class ServiceAPPlogin {
  String ?optionName;
  int ?iD;
  bool ?canViewYN;
  bool ?canCreateYN;
  bool ?canUpdateYN;
  bool ?canDeleteYN;
  bool ?canPrintYN;
  bool ?canExportYN;
  int ?companyID;
  int ?userMasterID;

  ServiceAPPlogin(
      {this.optionName,
        this.iD,
        this.canViewYN,
        this.canCreateYN,
        this.canUpdateYN,
        this.canDeleteYN,
        this.canPrintYN,
        this.canExportYN,
        this.companyID,
        this.userMasterID});

  ServiceAPPlogin.fromJson(Map<String, dynamic> json) {
    optionName = json['OptionName'];
    iD = json['ID'];
    canViewYN = json['CanViewYN'];
    canCreateYN = json['CanCreateYN'];
    canUpdateYN = json['CanUpdateYN'];
    canDeleteYN = json['CanDeleteYN'];
    canPrintYN = json['CanPrintYN'];
    canExportYN = json['CanExportYN'];
    companyID = json['CompanyID'];
    userMasterID = json['UserMasterID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OptionName'] = this.optionName;
    data['ID'] = this.iD;
    data['CanViewYN'] = this.canViewYN;
    data['CanCreateYN'] = this.canCreateYN;
    data['CanUpdateYN'] = this.canUpdateYN;
    data['CanDeleteYN'] = this.canDeleteYN;
    data['CanPrintYN'] = this.canPrintYN;
    data['CanExportYN'] = this.canExportYN;
    data['CompanyID'] = this.companyID;
    data['UserMasterID'] = this.userMasterID;
    return data;
  }
}