class MPPMasterModel {
  final int responseStatus;
  final String responseMessage;
  final ResponseData? responseData;

  MPPMasterModel({
    required this.responseStatus,
    required this.responseMessage,
    this.responseData,
  });

  factory MPPMasterModel.fromJson(Map<String, dynamic> json) {
    return MPPMasterModel(
      responseStatus: json['responseStatus'],
      responseMessage: json['responseMessage'],
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
  final List<Table> table;

  ResponseData({required this.table});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      table: (json['table'] as List)
          .map((item) => Table.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table': table.map((item) => item.toJson()).toList(),
    };
  }
}

class Table {
  final String code;
  final String mppName;
  final bool status;
  final String effectiveDate;
  final int socCode;
  final String routecode;
  final String rtName;
  final int rtcCode;
  final String bmccode;
  final String bmcname;
  final String mccCode;
  final String mccName;
  final String plantCode;
  final String plantName;
  final int companyCode;
  final String companyName;
  final String effectivedate1;
  final String add1;
  final int cntDocks;

  Table({
    required this.code,
    required this.mppName,
    required this.status,
    required this.effectiveDate,
    required this.socCode,
    required this.routecode,
    required this.rtName,
    required this.rtcCode,
    required this.bmccode,
    required this.bmcname,
    required this.mccCode,
    required this.mccName,
    required this.plantCode,
    required this.plantName,
    required this.companyCode,
    required this.companyName,
    required this.effectivedate1,
    required this.add1,
    required this.cntDocks,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      code: json['code'],
      mppName: json['mppName'],
      status: json['status'],
      effectiveDate: json['effectiveDate'],
      socCode: json['socCode'],
      routecode: json['routecode'],
      rtName: json['rtName'],
      rtcCode: json['rtcCode'],
      bmccode: json['bmccode'],
      bmcname: json['bmcname'],
      mccCode: json['mccCode'],
      mccName: json['mccName'],
      plantCode: json['plantCode'],
      plantName: json['plantName'],
      companyCode: json['companyCode'],
      companyName: json['companyName'],
      effectivedate1: json['effectivedate1'],
      add1: json['add1'],
      cntDocks: json['cntDocks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'mppName': mppName,
      'status': status,
      'effectiveDate': effectiveDate,
      'socCode': socCode,
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
      'effectivedate1': effectivedate1,
      'add1': add1,
      'cntDocks': cntDocks,
    };
  }
}
