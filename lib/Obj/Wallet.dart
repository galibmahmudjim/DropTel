import 'Activity.dart';
import 'Statement.dart';

class Wallet {
  String? _sId;
  String? _eventID;
  String? _eventName;
  String? _dateTime;
  String? _title;
  String? _type;
  List<Statement>? _statements;
  List<Activity>? _activities;

  Wallet(
      {String? sId,
      String? eventID,
      String? eventName,
      String? dateTime,
      String? title,
      String? type,
      List<Statement>? statements,
      List<Activity>? activities}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (eventID != null) {
      this._eventID = eventID;
    }
    if (eventName != null) {
      this._eventName = eventName;
    }
    if (dateTime != null) {
      this._dateTime = dateTime;
    }
    if (title != null) {
      this._title = title;
    }
    if (type != null) {
      this._type = type;
    }
    if (statements != null) {
      this._statements = statements;
    }
    if (activities != null) {
      this._activities = activities;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get eventID => _eventID;
  set eventID(String? eventID) => _eventID = eventID;
  String? get eventName => _eventName;
  set eventName(String? eventName) => _eventName = eventName;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get type => _type;
  set type(String? type) => _type = type;
  List<Statement>? get statements => _statements;
  set statements(List<Statement>? statements) => _statements = statements;
  List<Activity>? get activities => _activities;
  set activities(List<Activity>? activities) => _activities = activities;

  Wallet.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _eventID = json['EventID'];
    _eventName = json['EventName'];
    _dateTime = json['DateTime'];
    _title = json['Title'];
    _type = json['type'];
    if (json['statements'] != null) {
      _statements = <Statement>[];
      json['statements'].forEach((v) {
        _statements!.add(new Statement.fromJson(v));
      });
    }
    if (json['Activities'] != null) {
      _activities = <Activity>[];
      json['Activities'].forEach((v) {
        _activities!.add(new Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['EventID'] = this._eventID;
    data['EventName'] = this._eventName;
    data['DateTime'] = this._dateTime;
    data['Title'] = this._title;
    data['type'] = this._type;
    if (this._statements != null) {
      data['statements'] = this._statements!.map((v) => v.toJson()).toList();
    }
    if (this._activities != null) {
      data['Activities'] = this._activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
