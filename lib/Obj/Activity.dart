import 'ActivityList.dart';
import 'Statement.dart';

class Activity extends ActivityList {
  String? _description;
  List<Statement>? _statements;

  Activity(
      {String? sId,
      String? title,
      String? type,
      String? dateTime,
      String? description,
      List<Statement>? statements}) {
    if (sId != null) {
      super.sId = sId;
    }
    if (title != null) {
      super.title = title;
    }
    if (dateTime != null) {
      super.dateTime = dateTime;
    }
    if (type != null) {
      super.type = type;
    }
    if (description != null) {
      this._description = description;
    }
    if (statements != null) {
      this._statements = statements;
    }
  }

  String? get sId => super.sId;
  set sId(String? sId) => super.sId = sId;
  String? get title => super.title;
  set title(String? title) => super.title = title;
  String? get dateTime => super.dateTime;
  set dateTime(String? dateTime) => super.dateTime = dateTime;
  String? get type => super.type;
  set type(String? type) => super.type = type;
  List<Statement>? get statements => _statements;
  set statements(List<Statement>? statements) => _statements = statements;

  String? get description => _description;
  set description(String? description) => _description = description;

  Activity.fromJson(Map<String, dynamic> json) {
    super.sId = json['_id'];
    super.title = json['Title'];
    super.dateTime = json['DateTime'];
    super.type = json['Type'];
    _description = json['Description'];
    if (json['Statements'] != null) {
      _statements = <Statement>[];
      json['Statements'].forEach((v) {
        _statements!.add(new Statement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = super.sId;
    data['Title'] = super.title;
    data['DateTime'] = super.dateTime;
    data['Type'] = super.type;
    data['Description'] = this._description;

    if (this._statements != null) {
      data['Statements'] = this._statements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
