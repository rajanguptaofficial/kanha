class RateHeaderMasterReportModel {
  int? responseStatus;
  String? responseMessage;
  ResponseData? responseData;

  RateHeaderMasterReportModel(
      {this.responseStatus, this.responseMessage, this.responseData});

  RateHeaderMasterReportModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    responseData = json['responseData'] != null
        ? new ResponseData.fromJson(json['responseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseStatus'] = this.responseStatus;
    data['responseMessage'] = this.responseMessage;
    if (this.responseData != null) {
      data['responseData'] = this.responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  List<Table>? table;

  ResponseData({this.table});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['table'] != null) {
      table = <Table>[];
      json['table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['table'] = this.table!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  int? rateCode;
  String? otherCode;
  String? description;
  String? effectiveDate;
  String? effectiveShift;
  int? cId;

  Table(
      {this.rateCode,
      this.otherCode,
      this.description,
      this.effectiveDate,
      this.effectiveShift,
      this.cId});

  Table.fromJson(Map<String, dynamic> json) {
    rateCode = json['rateCode'];
    otherCode = json['otherCode'];
    description = json['description'];
    effectiveDate = json['effectiveDate'];
    effectiveShift = json['effectiveShift'];
    cId = json['cId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateCode'] = this.rateCode;
    data['otherCode'] = this.otherCode;
    data['description'] = this.description;
    data['effectiveDate'] = this.effectiveDate;
    data['effectiveShift'] = this.effectiveShift;
    data['cId'] = this.cId;
    return data;
  }
}
