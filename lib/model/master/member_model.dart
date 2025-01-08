class MemberMasterModel {
  final int responseStatus;
  final String responseMessage;
  final ResponseData responseData;

  MemberMasterModel({
    required this.responseStatus,
    required this.responseMessage,
    required this.responseData,
  });

  factory MemberMasterModel.fromJson(Map<String, dynamic> json) {
    return MemberMasterModel(
      responseStatus: json['responseStatus'] as int,
      responseMessage: json['responseMessage'] as String,
      responseData: ResponseData.fromJson(json['responseData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseStatus': responseStatus,
      'responseMessage': responseMessage,
      'responseData': responseData.toJson(),
    };
  }
}

class ResponseData {
  final List<Member> table;

  ResponseData({required this.table});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var list = json['table'] as List;
    List<Member> tableList = list.map((i) => Member.fromJson(i)).toList();

    return ResponseData(table: tableList);
  }

  Map<String, dynamic> toJson() {
    return {
      'table': table.map((e) => e.toJson()).toList(),
    };
  }
}

class Member {
  final String firstName;
  final String otherCode;
  final int socCode;
  final String code;
  final String mppName;
  final bool status;
  final String effectiveDate;
  final int socCode1;
  final String? routecode;
  final String? rtName;
  final String? rtcCode;
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

  Member({
    required this.firstName,
    required this.otherCode,
    required this.socCode,
    required this.code,
    required this.mppName,
    required this.status,
    required this.effectiveDate,
    required this.socCode1,
    this.routecode,
    this.rtName,
    this.rtcCode,
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

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      firstName: json['firstName'] as String,
      otherCode: json['otherCode'] as String,
      socCode: json['socCode'] as int,
      code: json['code'] as String,
      mppName: json['mppName'] as String,
      status: json['status'] as bool,
      effectiveDate: json['effectiveDate'] as String,
      socCode1: json['socCode1'] as int,
      routecode: json['routecode'] as String?,
      rtName: json['rtName'] as String?,
      rtcCode: json['rtcCode'] as String?,
      bmccode: json['bmccode'] as String,
      bmcname: json['bmcname'] as String,
      mccCode: json['mccCode'] as String,
      mccName: json['mccName'] as String,
      plantCode: json['plantCode'] as String,
      plantName: json['plantName'] as String,
      companyCode: json['companyCode'] as int,
      companyName: json['companyName'] as String,
      effectivedate1: json['effectivedate1'] as String,
      add1: json['add1'] as String,
      cntDocks: json['cntDocks'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'otherCode': otherCode,
      'socCode': socCode,
      'code': code,
      'mppName': mppName,
      'status': status,
      'effectiveDate': effectiveDate,
      'socCode1': socCode1,
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
