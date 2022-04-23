class UserModel {
  String? name;
  String? phone;
  String? email;
  String? password;

  UserModel({this.name, this.phone, this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
