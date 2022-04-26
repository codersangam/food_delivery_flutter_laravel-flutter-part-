class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  int? orderCount;

  UserModel(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.password,
      this.orderCount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['f_name'],
        email: json['email'],
        password: json['password'],
        orderCount: json['order_count']);
  }
}
