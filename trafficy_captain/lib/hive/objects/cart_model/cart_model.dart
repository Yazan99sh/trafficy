import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late int quantity;
  @HiveField(2)
  late double price;
  @HiveField(3)
  late String? name;
  @HiveField(4)
  late String? image;

  CartModel(
      {required this.id,
      required this.quantity,
      required this.price,
      this.image,
      this.name});

  CartModel.fromJson(dynamic json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson(CartModel carts) {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['quantity'] = quantity;
    map['price'] = price;
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}
