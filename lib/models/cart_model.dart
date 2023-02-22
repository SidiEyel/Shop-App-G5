class CartsModel {
  late bool status;
  late String message;
  late Data data;

  CartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

}

class Data {
  late int currentPage;
  late List<CartsData> data;
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late Null nextPageUrl;
  late String path;
  late int perPage;
  late Null prevPageUrl;
  late int to;
  late int total;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CartsData>[];
      json['data'].forEach((v) {
        data.add(new CartsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class CartsData {
  late int id;
  late Product product;


  CartsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
  }

}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}