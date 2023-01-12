import 'package:fashion_store/repositories/home_repo/home_network_repo.dart';
import 'package:fashion_store/repositories/profile_repo/profile_network_repo.dart';
import 'package:fashion_store/shared/bloc_observer.dart';
import 'package:fashion_store/shared/cache_helper.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/shared/theme/theme.dart';
import 'package:fashion_store/view/Screens/auth_screen.dart';
import 'package:fashion_store/view/Screens/categories_screen.dart';
import 'package:fashion_store/view/Screens/display_all_products_screen.dart';
import 'package:fashion_store/view/Screens/home_screen.dart';
import 'package:fashion_store/view/Screens/profile_screen.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:fashion_store/view_model/profile_view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.cacheInitialization();
  userId = CacheHelper.getCacheData('userId');
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context)=> HomeCubit(homeRepository: HomeNetworkRepository())..getCategories()..getAllProducts(limits: 4, offset: 60),),
        BlocProvider(create: (context)=> ProfileCubit(profileRepository: ProfileNetworkRepository())..getUserInfo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: userId != null ? HomeScreen() : AuthScreen(),
        theme: lightTheme,
        routes:
        {
          'category_screen' : (context) => const CategoriesScreen(),
          'auth_screen' : (context) => AuthScreen(),
          'all_products_screen' : (context) => const DisplayAllProductsScreen(),
        },
      ),
    );
  }
}