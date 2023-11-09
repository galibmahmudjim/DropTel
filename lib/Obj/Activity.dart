import 'Statement.dart';

class Activity {
  String? _title;
  String? _dateTime;
  List<Statement>? _statements;

  Activity({String? title, String? dateTime, List<Statement>? statements}) {
    if (title != null) {
      this._title = title;
    }
    if (dateTime != null) {
      this._dateTime = dateTime;
    }
    if (statements != null) {
      this._statements = statements;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  List<Statement>? get statements => _statements;
  set statements(List<Statement>? statements) => _statements = statements;

  Activity.fromJson(Map<String, dynamic> json) {
    _title = json['Title'];
    _dateTime = json['DateTime'];
    if (json['Statements'] != null) {
      _statements = <Statement>[];
      json['Statements'].forEach((v) {
        _statements!.add(new Statement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this._title;
    data['DateTime'] = this._dateTime;
    if (this._statements != null) {
      data['Statements'] = this._statements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
