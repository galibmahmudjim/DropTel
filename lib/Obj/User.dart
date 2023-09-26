/// email : "user@example.com"
/// password : "hashed_password"
/// name : "John Doe"
/// date_of_birth : "1990-01-15"

class User {
  User({
    String? email,
    String? password,
    String? name,
    String? dateOfBirth,
  }) {
    _email = email;
    _password = password;
    _name = name;
    _dateOfBirth = dateOfBirth;
  }

  User.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _name = json['name'];
    _dateOfBirth = json['date_of_birth'];
  }
  String? _email;
  String? _password;
  String? _name;
  String? _dateOfBirth;
  User copyWith({
    String? email,
    String? password,
    String? name,
    String? dateOfBirth,
  }) =>
      User(
        email: email ?? _email,
        password: password ?? _password,
        name: name ?? _name,
        dateOfBirth: dateOfBirth ?? _dateOfBirth,
      );
  String? get email => _email;
  String? get password => _password;
  String? get name => _name;
  String? get dateOfBirth => _dateOfBirth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    map['name'] = _name;
    map['date_of_birth'] = _dateOfBirth;
    return map;
  }
}
