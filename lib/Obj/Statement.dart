import 'package:droptel/Obj/PersonalTransition.dart';

class Statement {
  String? _sId;
  String? _title;
  String? _type;
  String? _dateTime;
  bool? _isCustomOperation;
  String? _operation;
  double? _amount;
  double? _operationValue;
  double? _total;
  int? _countMembers;
  double? _totalPerPerson;
  double? _totalWithMembers;
  List<PersonalTransition>? _members = [];

  Statement(
      {String? sId,
      String? title,
      String? type,
      bool? isCustomOperation,
      String? dateTime,
      String? operation,
      double? amount,
      double? operationValue,
      double? total,
      int? countMembers,
      double? totalPerPerson,
      double? totalWithMembers,
      List<PersonalTransition>? member}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (title != null) {
      this._title = title;
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
    if (amount != null) {
      this._amount = amount;
    }
    if (operationValue != null) {
      this._operationValue = operationValue;
    }
    if (total != null) {
      this._total = total;
    }
    if (countMembers != null) {
      this._countMembers = countMembers;
    }
    if (totalPerPerson != null) {
      this._totalPerPerson = totalPerPerson;
    }
    if (totalWithMembers != null) {
      this._totalWithMembers = totalWithMembers;
    }
    this._members = member;
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  bool? get isCustomOperation => _isCustomOperation;
  set isCustomOperation(bool? isCustomOperation) =>
      _isCustomOperation = isCustomOperation;
  String? get operation => _operation;
  set operation(String? operation) => _operation = operation;

  double? get amount => _amount;
  set amount(double? amount) => _amount = amount;
  double? get operationValue => _operationValue;
  set operationValue(double? operationValue) =>
      _operationValue = operationValue;
  double? get total => _total;
  set total(double? total) => _total = total;
  int? get countMembers => _countMembers;
  set countMembers(int? countMembers) => _countMembers = countMembers;
  double? get totalPerPerson => _totalPerPerson;
  set totalPerPerson(double? totalPerPerson) =>
      _totalPerPerson = totalPerPerson;
  double? get totalWithMembers => _totalWithMembers;
  set totalWithMembers(double? totalWithMembers) =>
      _totalWithMembers = totalWithMembers;

  List<PersonalTransition?> get members => _members ?? [];
  set eventGuest(List<PersonalTransition> members) => _members = members;

  Statement.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _title = json['Title'];
    _type = json['Type'];
    _isCustomOperation = json['isCustomOperation'];
    _operation = json['Operation'];
    _dateTime = json['DateTime'];
    _amount = json['amount'];
    _operationValue = json['operationValue'];
    _total = json['total'];
    _countMembers = json['countMembers'];
    _totalPerPerson = json['totalPerPerson'];
    _totalWithMembers = json['totalWithMembers'];
    if (json['EventGuest'] != null) {
      _members = <PersonalTransition>[];
      json['Members'].forEach((v) {
        _members?.add(new PersonalTransition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['Title'] = this._title;
    data['Type'] = this._type;
    data['isCustomOperation'] = this._isCustomOperation;
    data['DateTime'] = this._dateTime;
    data['Operation'] = this._operation;
    data['amount'] = this._amount;
    data['operationValue'] = this._operationValue;
    data['total'] = this._total;
    data['countMembers'] = this._countMembers;
    data['totalPerPerson'] = this._totalPerPerson;
    data['totalWithMembers'] = this._totalWithMembers;
    data['Members'] = this._members?.map((v) => v.toJson()).toList();
    return data;
  }
}
