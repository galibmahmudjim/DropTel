import 'EventGuest.dart';

class PersonalTransition {
  String? _sId;
  double? _amount;
  String? _type;
  EventGuest? _member;

  PersonalTransition(
      {String? sId, double? amount, String? type, EventGuest? member}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (amount != null) {
      this._amount = amount;
    }
    if (type != null) {
      this._type = type;
    }
    if (member != null) {
      this._member = member;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  double? get amount => _amount;
  set amount(double? amount) => _amount = amount;
  String? get type => _type;
  set type(String? type) => _type = type;
  EventGuest? get member => _member;
  set eventGuest(EventGuest? eventGuest) => _member = eventGuest;

  PersonalTransition.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _amount = json['Amount'];
    _type = json['Type'];
    _member = json['Members'] != null
        ? new EventGuest.fromJson(json['Members'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['Amount'] = this._amount;
    data['Type'] = this._type;
    if (this._member != null) {
      data['Members'] = this._member!.toJson();
    }
    return data;
  }
}
