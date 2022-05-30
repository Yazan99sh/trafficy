import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:trafficy_admin/hive/objects/cart_model/cart_model.dart';

class HiveSetUp {
  static Future<void> init() async {
    await Hive.initFlutter();
    await adapterRegistration();
    await publicBoxes();
  }

  static Future<void> adapterRegistration() async {
    Hive.registerAdapter(CartModelAdapter());
  }

  static Future<void> publicBoxes() async {
    await Hive.openBox('Authorization');
    await Hive.openBox('Theme');
    await Hive.openBox('Localization');
    await Hive.openBox('Order');
    await Hive.openBox('Chat');
    await Hive.openBox('Notification');
    await Hive.openBox('Argument');
  }
}
