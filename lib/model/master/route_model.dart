import 'dart:convert';

class RouteMasterModel {
  final int? responseStatus;
  final String? responseMessage;
  final ResponseData? responseData;

  RouteMasterModel({
    this.responseStatus,
    this.responseMessage,
    this.responseData,
  });

  factory RouteMasterModel.fromJson(Map<String, dynamic> json) {
    return RouteMasterModel(
      responseStatus: json['responseStatus'] as int?,
      responseMessage: json['responseMessage'] as String?,
      responseData: json['responseData'] != null
          ? ResponseData.fromJson(json['responseData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseStatus': responseStatus,
      'responseMessage': responseMessage,
      'responseData': responseData?.toJson(),
    };
  }
}

class ResponseData {
  final List<TableModel>? table;

  ResponseData({this.table});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      table: json['table'] != null
          ? (json['table'] as List)
              .map((e) => TableModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table': table?.map((e) => e.toJson()).toList(),
    };
  }
}

class TableModel {
  final String? routecode;
  final String? rtName;
  final int? rtcCode;
  final String? bmccode;
  final String? bmcname;
  final String? mccCode;
  final String? mccName;
  final String? plantCode;
  final String? plantName;
  final int? companyCode;
  final String? companyName;
  final String? effectivedate;
  final String? add1;
  final int? cntDocks;

  TableModel({
    this.routecode,
    this.rtName,
    this.rtcCode,
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
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      routecode: json['routecode'] as String?,
      rtName: json['rtName'] as String?,
      rtcCode: json['rtcCode'] as int?,
      bmccode: json['bmccode'] as String?,
      bmcname: json['bmcname'] as String?,
      mccCode: json['mccCode'] as String?,
      mccName: json['mccName'] as String?,
      plantCode: json['plantCode'] as String?,
      plantName: json['plantName'] as String?,
      companyCode: json['companyCode'] as int?,
      companyName: json['companyName'] as String?,
      effectivedate: json['effectivedate'] as String?,
      add1: json['add1'] as String?,
      cntDocks: json['cntDocks'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routecode': routecode,
      'rtName': rtName,
      'rtcCode': rtcCode,
      'bmccode': bmccode,
      'bmcname': bmcname,
      'mccCode': mccCode,
      'mccName': mccName,
      'plantCode': plantCode,
      'plantName': plantName,
      'companyCode': companyCode,
      'companyName': companyName,
      'effectivedate': effectivedate,
      'add1': add1,
      'cntDocks': cntDocks,
    };
  }
}
