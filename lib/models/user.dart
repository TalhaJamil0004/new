class UserModel {
  String? name;
  String? email;
  String? password;
  String? cardNumber;
  int? money;

  UserModel(
      {this.name, this.email, this.password, this.cardNumber, this.money});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    cardNumber = json['cardNumber'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['cardNumber'] = cardNumber;
    data['money'] = money;
    return data;
  }
}
