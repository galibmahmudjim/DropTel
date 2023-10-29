class User {
  String? _email;
  String? _password;
  String? _name;
  String? _dateofBirth;
  String? _id;
  String? _imageURL;

  User(
      {String? id,
      String? email,
      String? password,
      String? name,
      String? dateofBirth,
      String? imageURL}) {
    if (id != null) {
      this._id = id;
    }
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
    if (name != null) {
      this._name = name;
    }
    if (dateofBirth != null) {
      this._dateofBirth = dateofBirth;
    }
    if (imageURL != null) {
      this._imageURL = imageURL;
    }
  }

  String? get id => _id;

  set id(String? id) => _id = id;

  String? get email => _email;

  set email(String? email) => _email = email;

  String? get password => _password;

  set password(String? password) => _password = password;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get dateofBirth => _dateofBirth;

  set dateofBirth(String? dateofBirth) => _dateofBirth = dateofBirth;

  String? get imageURL => _imageURL;

  set imageURL(String? imageURL) => _imageURL = imageURL;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _email = json['Email'];
    _password = json['Password'];
    _name = json['Name'];
    _dateofBirth = json['DateofBirth'];
    _imageURL = json['ImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._id;
    data['Email'] = this._email;
    data['Password'] = this._password;
    data['Name'] = this._name;
    data['DateofBirth'] = this._dateofBirth;
    data['ImageURL'] = this._imageURL;
    return data;
  }
}
