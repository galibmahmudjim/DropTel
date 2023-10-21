class EventGuest {
  int? _index;
  String? _name;
  String? _email;
  String? _color;
  String? _isAttending;

  EventGuest(
      {int? index,
      String? name,
      String? email,
      String? color,
      String? isAttending}) {
    if (index != null) {
      this._index = index;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (color != null) {
      this._color = color;
    }
    if (isAttending != null) {
      this._isAttending = isAttending;
    }
  }

  int? get index => _index;
  set index(int? index) => _index = index;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get color => _color;
  set color(String? color) => _color = color;
  String? get isAttending => _isAttending;
  set isAttending(String? isAttending) => _isAttending = isAttending;

  EventGuest.fromJson(Map<String, dynamic> json) {
    _index = json['Index'];
    _name = json['Name'];
    _email = json['Email'];
    _color = json['Color'];
    _isAttending = json['isAttending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Index'] = this._index;
    data['Name'] = this._name;
    data['Email'] = this._email;
    data['Color'] = this._color;
    data['isAttending'] = this._isAttending;
    return data;
  }
}
