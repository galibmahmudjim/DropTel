import 'package:droptel/Obj/ActivityList.dart';
import 'package:droptel/Obj/PersonalTransition.dart';

class Statement extends ActivityList {
  bool? _isCustomOperation;
  String? _operation;
  double? _amount;
  String? _calculationTitle;
  String? _statementType;
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
      String? statementType,
      bool? isCustomOperation,
      String? dateTime,
      String? operation,
      String? CalculationTitle,
      double? amount,
      double? operationValue,
      double? total,
      int? countMembers,
      double? totalPerPerson,
      double? totalWithMembers,
      List<PersonalTransition>? member}) {
    if (sId != null) {
      super.sId = sId;
    }
    if (title != null) {
      super.title = title;
    }
    if (CalculationTitle != null) {
      this._calculationTitle = CalculationTitle;
    }
    if (type != null) {
      super.type = type;
    }
    if (statementType != null) {
      this._statementType = statementType;
    }
    if (dateTime != null) {
      super.dateTime = dateTime;
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

  String? get sId => super.sId;
  set sId(String? sId) => super.sId = sId;
  String? get title => super.title;
  set title(String? title) => super.title = title;

  String? get calculationTitle => _calculationTitle;
  set calculationTitle(String? calculationTitle) =>
      _calculationTitle = calculationTitle;
  String? get type => super.type;
  set type(String? type) => super.type = type;
  String? get statementType => _statementType;
  set statementType(String? statementType) => _statementType = statementType;
  String? get dateTime => super.dateTime;
  set dateTime(String? dateTime) => super.dateTime = dateTime;
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
    super.sId = json['_id'];
    super.title = json['Title'];
    super.type = json['Type'];
    _statementType = json['statementType'];
    _isCustomOperation = json['isCustomOperation'];
    _operation = json['Operation'];
    super.dateTime = json['DateTime'];
    _amount = json['amount'];
    _operationValue = json['operationValue'];
    _total = json['total'];

    _calculationTitle = json['CalculationTitle'];
    _countMembers = json['countMembers'];
    _totalPerPerson = json['totalPerPerson'];
    _totalWithMembers = json['totalWithMembers'];
    if (json['Members'] != null) {
      _members = <PersonalTransition>[];
      json['Members'].forEach((v) {
        _members?.add(new PersonalTransition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = super.sId;
    data['Title'] = super.title;
    data['Type'] = super.type;
    data['statementType'] = this._statementType;
    data['isCustomOperation'] = this._isCustomOperation;
    data['DateTime'] = super.dateTime;
    data['Operation'] = this._operation;
    data['CalculationTitle'] = this._calculationTitle;

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
