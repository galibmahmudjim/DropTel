import 'package:droptel/Obj/Activity.dart';
import 'package:droptel/Obj/ActivityList.dart';
import 'package:droptel/Obj/Statement.dart';

class Wallet {
  String? _sId;
  String? _eventID;
  String? _eventName;
  String? _dateTime;
  String? _title;
  String? _type;
  List<ActivityList>? _activityList;

  Wallet({
    String? sId,
    String? eventID,
    String? eventName,
    String? dateTime,
    String? title,
    String? type,
    List<ActivityList>? activityList,
  }) {
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
    if (activityList != null) {
      this._activityList = activityList;
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
  List<ActivityList>? get activityList => _activityList;
  set activityList(List<ActivityList>? activityList) =>
      _activityList = activityList;

  Wallet.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _eventID = json['EventID'];
    _eventName = json['EventName'];
    _dateTime = json['DateTime'];
    _title = json['Title'];
    _type = json['type'];
    if (json['ActivityList'] != null) {
      _activityList = <ActivityList>[];
      json['ActivityList'].forEach((v) {
        if (v['Type'] == "Statement") {
          _activityList!.add(Statement.fromJson(v));
        } else if (v['Type'] == "Activity") {
          _activityList!.add(new Activity.fromJson(v));
        }
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

    if (this._activityList != null) {
      data['ActivityList'] = this._activityList!.map((v) {
        if (v.type == "Statement") {
          return (v as Statement).toJson();
        } else if (v.type == "Activity") {
          return (v as Activity).toJson();
        }
      }).toList();
    }

    return data;
  }
}
