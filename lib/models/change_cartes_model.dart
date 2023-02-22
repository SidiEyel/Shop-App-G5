class cartsModel{

  late bool status;
  late String message;

  cartsModel.fromJson(Map<String, dynamic> json){

    status = json['status'];
    message = json['message'];

  }

}