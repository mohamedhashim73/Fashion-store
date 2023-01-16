import 'package:flutter/services.dart';
import '../../view/Screens/auth_screen.dart';
import '../../view/Screens/categories_screen.dart';
import '../../view/Screens/display_all_products_screen.dart';
import '../../view/Screens/profile_screen.dart';
import '../../view/Screens/update_profile_screen.dart';

int? userId ;
const String userImage = "https://en.wikipedia.org/wiki/Image#/media/File:Image_created_with_a_mobile_phone.png";
const List<String> bannersImages =
[
  'assets/images/banner1.png',
  'assets/images/banner2.png',
  'assets/images/banner3.png',
];
var appRoutes = {
  'category_screen' : (context) => const CategoriesScreen(),
  'auth_screen' : (context) => AuthScreen(),
  'profile_screen' : (context) => ProfileScreen(),
  'update_screen' : (context) => UpdateProfileScreen(),
  'all_products_screen' : (context) => const DisplayAllProductsScreen(),
};

const List<DeviceOrientation> deviceOrientations = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];