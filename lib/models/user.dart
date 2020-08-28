

class User {
  String _login;
  String _password;
  String _token;
  String _refresh_token;

  User(this._login, this._password);

  String get refresh_token => _refresh_token;

  User.map(dynamic obj) {
//    this._password = obj['password'];
    this._login = obj['username'];
    this._refresh_token = obj['refresh_token'];
    this._token = obj['token'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['login'] = _login;
    map['password'] = _password;
    return map;
  }

}