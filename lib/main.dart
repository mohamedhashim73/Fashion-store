import 'package:fashion_store/repositories/favorites_orders_repo/favorites_orders_network_repo.dart';
import 'package:fashion_store/repositories/home_repo/home_network_repo.dart';
import 'package:fashion_store/repositories/profile_repo/profile_network_repo.dart';
import 'package:fashion_store/shared/bloc_observer.dart';
import 'package:fashion_store/shared/network/cache_helper.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/shared/theme/theme.dart';
import 'package:fashion_store/view/Screens/auth_screen.dart';
import 'package:fashion_store/view/Screens/home_screen.dart';
import 'package:fashion_store/view_model/favorites_orders_view_model/favorites_orders_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:fashion_store/view_model/profile_view_model/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(deviceOrientations);  // enable only on portraitUp and portraitDown
  await CacheHelper.cacheInitialization();
  userId = CacheHelper.getCacheData('UserID');
  debugPrint("User is is .............. $userId");
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
        BlocProvider(create: (context)=> FavoritesAndOrdersCubit(favoritesAndOrdersNetworkRepo: FavoritesAndOrdersNetworkRepository())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: userId != null ? HomeScreen() : AuthScreen(),
            theme: lightTheme,
            routes: appRoutes,
          );
        },
      ),
    );
  }
}