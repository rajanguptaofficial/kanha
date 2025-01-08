class BmcMasterModel {
  int? responseStatus;
  String? responseMessage;
  ResponseData? responseData;

  BmcMasterModel({this.responseStatus, this.responseMessage, this.responseData});

  factory BmcMasterModel.fromJson(Map<String, dynamic> json) {
    return BmcMasterModel(
      responseStatus: json['responseStatus'],
      responseMessage: json['responseMessage'],
      responseData: json['responseData'] != null
          ? ResponseData.fromJson(json['responseData'])
          : null,
    );
  }
}

class ResponseData {
  List<TableData>? table;

  ResponseData({this.table});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      table: (json['table'] as List).map((e) => TableData.fromJson(e)).toList(),
    );
  }
}

class TableData {
  String? bmccode;
  String? bmcname;
  String? mccCode;
  String? mccName;
  String? plantCode;
  String? plantName;
  int? companyCode;
  String? companyName;
  String? effectivedate;
  String? add1;
  int? cntDocks;
  int? cntCode;

  TableData({
    this.bmccode,
    this.bmcname,
    this.mccCode,
    this.mccName,
    this.plantCode,
    this.plantName,
    this.companyCode,
    this.companyName,
    this.effectivedate,
    this.add1,
    this.cntDocks,
    this.cntCode,
  });

  factory TableData.fromJson(Map<String, dynamic> json) {
    return TableData(
      bmccode: json['bmccode'],
      bmcname: json['bmcname'],
      mccCode: json['mccCode'],
      mccName: json['mccName'],
      plantCode: json['plantCode'],
      plantName: json['plantName'],
      companyCode: json['companyCode'],
      companyName: json['companyName'],
      effectivedate: json['effectivedate'],
      add1: json['add1'],
      cntDocks: json['cntDocks'],
      cntCode: json['cntCode'],
    );
  }
}
