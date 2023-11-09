import 'EventGuest.dart';

class Statement {
  String? _title;
  int? _amount;
  String? _type;
  String? _dateTime;
  bool? _isCustomOperation;
  String? _operation;
  int? _operationValue;
  List<EventGuest>? _members;

  Statement(
      {String? title,
      int? amount,
      String? type,
      bool? isCustomOperation,
      String? dateTime,
      String? operation,
      int? operationValue,
      List<EventGuest>? member}) {
    if (title != null) {
      this._title = title;
    }
    if (amount != null) {
      this._amount = amount;
    }
    if (type != null) {
      this._type = type;
    }
    if (dateTime != null) {
      this._dateTime = dateTime;
    }
    if (isCustomOperation != null) {
      this._isCustomOperation = isCustomOperation;
    }
    if (operation != null) {
      this._operation = operation;
    }
    if (operationValue != null) {
      this._operationValue = operationValue;
    }
    if (member != null) {
      this._members = member;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  int? get amount => _amount;
  set amount(int? amount) => _amount = amount;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  bool? get isCustomOperation => _isCustomOperation;
  set isCustomOperation(bool? isCustomOperation) =>
      _isCustomOperation = isCustomOperation;
  String? get operation => _operation;
  set operation(String? operation) => _operation = operation;
  int? get operationValue => _operationValue;
  set operationValue(int? operationValue) => _operationValue = operationValue;
  List<EventGuest>? get members => _members;
  set eventGuest(List<EventGuest>? members) => _members = members;

  Statement.fromJson(Map<String, dynamic> json) {
    _title = json['Title'];
    _amount = json['Amount'];
    _type = json['Type'];
    _isCustomOperation = json['isCustomOperation'];
    _operation = json['Operation'];
    _dateTime = json['DateTime'];
    _operationValue = json['operationValue'];
    if (json['EventGuest'] != null) {
      _members = <EventGuest>[];
      json['Members'].forEach((v) {
        _members!.add(new EventGuest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this._title;
    data['Amount'] = this._amount;
    data['Type'] = this._type;
    data['isCustomOperation'] = this._isCustomOperation;
    data['DateTime'] = this._dateTime;
    data['Operation'] = this._operation;
    data['operationValue'] = this._operationValue;
    if (this._members != null) {
      data['Members'] = this._members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
