class LoginModel{
  late bool status;
  late String message;
  UserData? data;

  LoginModel.formJson(Map<String, dynamic> json){
    status = json['status']?? false;
    message = json['message']?? '';
    data = (json['data'] != null ? UserData.formJson(json['data']) : null);
    // data = (json['data']!=null ? UserData.formJson(json['data']) : null)!;
  }
}

class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserData.formJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
