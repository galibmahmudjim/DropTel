import 'EventGuest.dart';

class eventWallet {
  String? _sId;
  String? _title;
  String? _description;
  String? _date;
  String? _adminId;
  String? _adminEmail;
  String? _dateCreated;
  List<EventGuest>? _eventGuest;

  eventWallet(
      {String? sId,
      String? title,
      String? description,
      String? date,
      String? adminId,
      String? adminEmail,
      String? dateCreated,
      List<EventGuest>? eventGuest}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
    if (date != null) {
      this._date = date;
    }
    if (adminId != null) {
      this._adminId = adminId;
    }
    if (adminEmail != null) {
      this._adminEmail = adminEmail;
    }
    if (dateCreated != null) {
      this._dateCreated = dateCreated;
    }
    if (eventGuest != null) {
      this._eventGuest = eventGuest;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get adminId => _adminId;
  set adminId(String? adminId) => _adminId = adminId;
  String? get adminEmail => _adminEmail;
  set adminEmail(String? adminEmail) => _adminEmail = adminEmail;
  String? get dateCreated => _dateCreated;
  set dateCreated(String? dateCreated) => _dateCreated = dateCreated;
  List<EventGuest>? get eventGuest => _eventGuest;
  set eventGuest(List<EventGuest>? eventGuest) => _eventGuest = eventGuest;

  eventWallet.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _title = json['Title'];
    _description = json['Description'];
    _date = json['Date'];
    _adminId = json['AdminId'];
    _adminEmail = json['AdminEmail'];
    _dateCreated = json['DateCreated'];
    if (json['EventGuest'] != null) {
      _eventGuest = <EventGuest>[];
      json['EventGuest'].forEach((v) {
        _eventGuest!.add(new EventGuest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['Title'] = this._title;
    data['Description'] = this._description;
    data['Date'] = this._date;
    data['AdminId'] = this._adminId;
    data['AdminEmail'] = this._adminEmail;
    data['DateCreated'] = this._dateCreated;
    if (this._eventGuest != null) {
      data['EventGuest'] = this._eventGuest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
