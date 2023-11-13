abstract class ActivityList {
  String? _sId;
  String? _title;
  String? _type;
  String? _dateTime;

  ActivityList({String? sId, String? title, String? type, String? dateTime}) {
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
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
}
